// Ghostty cursor trail shader — Kitty-style smooth smear
// Requires Ghostty >= 1.2.0 (cursor uniforms: iCurrentCursor, iPreviousCursor, iTimeCursorChange)
//
// Install:
//   mkdir -p ~/.config/ghostty/shaders
//   cp cursor-trail.glsl ~/.config/ghostty/shaders/
//
// Add to ~/.config/ghostty/config:
//   custom-shader = ~/.config/ghostty/shaders/cursor-trail.glsl
//
// ── Tunables ────────────────────────────────────────────────────────────────
// How long (seconds) the trail animation lasts after the cursor moves.
const float DURATION = 0.45;

// Overall trail opacity (0.0 = invisible, 1.0 = fully opaque).
const float TRAIL_OPACITY = 0.18;

// How many cursor-widths the cursor must travel before a trail is drawn.
// Keeps the effect from appearing while you type in place.
const float DRAW_THRESHOLD = 1.4;

// When true, suppress trails when the cursor stays on the same terminal row
// (e.g. moving within a line while typing). Set false for full trails.
const bool HIDE_SAME_LINE_TRAILS = false;

// Trail colour. Defaults to white; set to iCurrentCursorColor for a
// colour-matched trail once that uniform is stable on your build.
const vec4 TRAIL_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
// ── End of tunables ─────────────────────────────────────────────────────────


// ── Helpers ─────────────────────────────────────────────────────────────────

// Smooth-step easing: starts fast, decelerates (matches kitty's feel).
float easeOut(float t) {
    return 1.0 - pow(1.0 - t, 3.0);
}

// Fade curve: the trail opacity decays with this shape over time.
float fadeTrail(float t) {
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

// Signed distance to an axis-aligned rectangle centred at `centre` with
// half-extents `halfSize`.  Negative = inside, positive = outside.
float sdRect(vec2 p, vec2 centre, vec2 halfSize) {
    vec2 d = abs(p - centre) - halfSize;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

// Signed distance to a parallelogram defined by four vertices (in order).
// Based on Inigo Quilez's 2-D distance function technique, branch-free.
float sdSegment(in vec2 p, in vec2 a, in vec2 b, inout float s) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float d = dot(p - proj, p - proj);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float flip = mix(1.0, -1.0, step(0.5, c0 * c1 * c2 + (1.0 - c0) * (1.0 - c1) * (1.0 - c2)));
    s *= flip;
    return d;
}

float sdParallelogram(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = sdSegment(p, v0, v3, s, d);   // note: passes d by value, updates s
    d = sdSegment(p, v1, v0, s, d);
    d = sdSegment(p, v2, v1, s, d);
    d = sdSegment(p, v3, v2, s, d);
    return s * sqrt(d);
}

// Workaround: sdSegment above is a port that takes d as a plain float param.
// Re-declare properly for the parallelogram accumulation:
float _seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float flip = mix(1.0, -1.0, step(0.5, c0 * c1 * c2 + (1.0 - c0) * (1.0 - c1) * (1.0 - c2)));
    s *= flip;
    return d;
}

float sdPara(vec2 p, vec2 v0, vec2 v1, vec2 v2, vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);
    d = _seg(p, v0, v3, s, d);
    d = _seg(p, v1, v0, s, d);
    d = _seg(p, v2, v1, s, d);
    d = _seg(p, v3, v2, s, d);
    return s * sqrt(d);
}

// Convert a value from pixel-space to Ghostty's normalised Y-height space.
// isPosition=1 offsets by the viewport origin; isPosition=0 just scales.
vec2 toNorm(vec2 v, float isPosition) {
    return (v * 2.0 - iResolution.xy * isPosition) / iResolution.y;
}

// 1-pixel anti-aliased coverage for an SDF value.
float aa(float dist) {
    float pixelSize = toNorm(vec2(1.5, 1.5), 0.0).x;
    return 1.0 - smoothstep(-pixelSize, pixelSize, dist);
}

// Decide which horizontal corner of the cursor to use as the parallelogram
// start vertex, so the shape stays convex regardless of movement direction.
float startVertexFactor(vec2 a, vec2 b) {
    float cond1 = step(b.x, a.x) * step(a.y, b.y); // moving up-left
    float cond2 = step(a.x, b.x) * step(b.y, a.y); // moving down-right
    return 1.0 - max(cond1, cond2);
}

vec2 rectCenter(vec4 r) {
    return vec2(r.x + r.z * 0.5, r.y - r.w * 0.5);
}


// ── Main ────────────────────────────────────────────────────────────────────
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Sample the terminal framebuffer (the rendered text/background).
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);

    // Normalised fragment coordinate in [-aspect..aspect] × [-1..1] space.
    vec2 uv = toNorm(fragCoord, 1.0);

    // Normalise cursor rects: xy = position, zw = size.
    vec4 cur  = vec4(toNorm(iCurrentCursor.xy,  1.0), toNorm(iCurrentCursor.zw,  0.0));
    vec4 prev = vec4(toNorm(iPreviousCursor.xy, 1.0), toNorm(iPreviousCursor.zw, 0.0));

    // --- Animation progress (0 → 1 over DURATION seconds) ---
    float rawProgress  = clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1.0);
    float progress     = easeOut(rawProgress);      // eased forward motion
    float fadeProgress = fadeTrail(rawProgress);    // opacity decay

    // --- Distance check: only draw if cursor moved far enough ---
    vec2  centerCur  = rectCenter(cur);
    vec2  centerPrev = rectCenter(prev);
    float cursorSize = max(cur.z, cur.w);
    float lineLen    = distance(centerCur, centerPrev);
    bool  farEnough  = lineLen > DRAW_THRESHOLD * cursorSize;
    bool  diffLine   = HIDE_SAME_LINE_TRAILS ? (iCurrentCursor.y != iPreviousCursor.y) : true;

    if (farEnough && diffLine) {
        // --- Build parallelogram vertices ---
        // The parallelogram bridges the previous cursor rect to the current
        // one, giving the classic kitty "smear" trail shape.
        vec2 offsetFactor = vec2(-0.5, 0.5);
        float vf  = startVertexFactor(cur.xy, prev.xy);
        float ivf = 1.0 - vf;

        vec2 v0 = vec2(cur.x  + cur.z  * vf,  cur.y  - cur.w );
        vec2 v1 = vec2(cur.x  + cur.z  * ivf, cur.y          );
        vec2 v2 = vec2(prev.x + cur.z  * ivf, prev.y         );
        vec2 v3 = vec2(prev.x + cur.z  * vf,  prev.y - prev.w);

        // --- SDFs ---
        float sdfTrail  = sdPara(uv, v0, v1, v2, v3);
        float sdfCursor = sdRect(uv,
            cur.xy - cur.zw * offsetFactor,
            cur.zw * 0.5);

        // --- Alpha modulator: trail fades from previous position toward current ---
        float distToEnd   = distance(uv, centerCur);
        float alphaFactor = clamp(distToEnd / (lineLen * max(fadeProgress, 0.001)), 0.0, 1.0);

        // --- Compose trail onto the framebuffer ---
        // Soft inner fill
        vec4 newColor = fragColor;
        float softEdge = 1.0 - smoothstep(-0.008, 0.004, sdfTrail);
        newColor = mix(newColor, TRAIL_COLOR, softEdge * TRAIL_OPACITY);

        // Crisp anti-aliased rim
        newColor = mix(newColor, TRAIL_COLOR, aa(sdfTrail) * TRAIL_OPACITY * 0.6);

        // Fade based on animation and distance from cursor head
        newColor = mix(fragColor, newColor, 1.0 - alphaFactor);

        // Restore original pixels under the cursor itself (don't paint over it).
        fragColor = mix(newColor, fragColor, step(sdfCursor, 0.0));
    }
}
