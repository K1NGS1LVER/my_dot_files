const float DURATION = 0.4;
const float TRAIL_OPACITY = 0.6;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    // Always read the base texture first
    #if !defined(WEB)
    fragColor = texture(iChannel0, uv);
    #endif

    // Check if animation is done - just return with the texture intact
    float dt = iTime - iTimeCursorChange;
    if (dt >= DURATION) return;

    float t = dt / DURATION;
    float t2 = t * t;
    float progress = t2 / (2.0 * (t2 - t) + 1.0);

    float invRY = 1.0 / iResolution.y;
    float invRY2 = invRY + invRY;

    vec2 vu = fragCoord * invRY2 - iResolution.xy * invRY;
    
    vec2 ccPos = iCurrentCursor.xy * invRY2 - iResolution.xy * invRY;
    vec2 ccSz  = iCurrentCursor.zw * invRY2;
    vec2 cpPos = iPreviousCursor.xy * invRY2 - iResolution.xy * invRY;
    vec2 cpSz  = iPreviousCursor.zw * invRY2;

    vec2 halfSzC = ccSz * 0.5;
    vec2 head = ccPos + vec2(halfSzC.x, -halfSzC.y);
    vec2 tail = cpPos + cpSz * 0.5 * vec2(1.0, -1.0);

    float cursorHalf = max(ccSz.x, ccSz.y) * 0.5;

    // Skip short movements
    vec2 diff = tail - head;
    float lenSq = dot(diff, diff);
    if (lenSq <= 9.0 * cursorHalf * cursorHalf) return;

    // Retract tail
    vec2 ba = mix(tail, head, progress) - head;
    float baSq = dot(ba, ba);
    if (baSq < 1e-6) return;

    // Bounding box early exit
    vec2 boxMin = min(head, head + ba) - cursorHalf;
    vec2 boxMax = max(head, head + ba) + cursorHalf;
    
    if (vu.x < boxMin.x || vu.x > boxMax.x || 
        vu.y < boxMin.y || vu.y > boxMax.y) {
        return;
    }

    // Capsule SDF
    vec2 pa = vu - head;
    float h = clamp(dot(pa, ba) / baSq, 0.0, 1.0);
    vec2 closest = pa - ba * h;
    float distSq = dot(closest, closest);

    float px = invRY2;
    float maxRSq = (cursorHalf + px) * (cursorHalf + px);
    if (distSq > maxRSq) return;

    float dist = sqrt(distSq) - cursorHalf;
    float mask = 1.0 - smoothstep(0.0, px, dist);

    float grad = 1.0 - h;
    float fade = 1.0 - progress;
    float alpha = mask * (grad * grad) * (fade * fade) * TRAIL_OPACITY;

    // Cursor occlusion
    vec2 d = abs(vu - head) - halfSzC;
    float cursorSdf = length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
    alpha *= step(0.0, cursorSdf);

    if (alpha < 0.005) return;

    fragColor = mix(fragColor, vec4(1.0), alpha);
}
