const float DURATION = 0.4;
const float TRAIL_OPACITY = 0.6;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    #if !defined(WEB)
    fragColor = texture(iChannel0, uv);
    #endif

    float dt = iTime - iTimeCursorChange;
    if (dt >= DURATION) return;

    float t = dt / DURATION;
    float progress = t * t / (2.0 * (t * t - t) + 1.0);

    float invRY = 1.0 / iResolution.y;
    vec2 vu = (fragCoord + fragCoord - iResolution.xy) * invRY;
    
    vec2 ccPos = (iCurrentCursor.xy + iCurrentCursor.xy - iResolution.xy) * invRY;
    vec2 ccSz  = iCurrentCursor.zw * (invRY + invRY);
    vec2 cpPos = (iPreviousCursor.xy + iPreviousCursor.xy - iResolution.xy) * invRY;
    vec2 cpSz  = iPreviousCursor.zw * (invRY + invRY);

    vec2 halfSzC = ccSz * 0.5;
    vec2 head = ccPos + vec2(halfSzC.x, -halfSzC.y);
    vec2 tail = cpPos + cpSz * vec2(0.5, -0.5);

    float cursorHalf = max(ccSz.x, ccSz.y) * 0.5;
    vec2 diff = tail - head;
    
    if (dot(diff, diff) <= 9.0 * cursorHalf * cursorHalf) return;

    vec2 ba = mix(tail, head, progress) - head;
    float baSq = dot(ba, ba);
    if (baSq < 1e-6) return;

    // Tight bounding box
    vec2 trailMin = min(head, head + ba) - cursorHalf - 0.01;
    vec2 trailMax = max(head, head + ba) + cursorHalf + 0.01;
    if (any(lessThan(vu, trailMin)) || any(greaterThan(vu, trailMax))) return;

    vec2 pa = vu - head;
    float h = clamp(dot(pa, ba) / baSq, 0.0, 1.0);
    float distSq = dot(pa - ba * h, pa - ba * h);

    float px = invRY + invRY;
    float maxRSq = cursorHalf + px;
    maxRSq *= maxRSq;
    if (distSq > maxRSq) return;

    float dist = sqrt(distSq) - cursorHalf;
    float mask = 1.0 - smoothstep(0.0, px, dist);

    float grad = 1.0 - h;
    float fade = 1.0 - progress;
    float alpha = mask * grad * grad * fade * fade * TRAIL_OPACITY;

    vec2 d = abs(vu - head) - halfSzC;
    alpha *= step(0.0, length(max(d, 0.0)) + min(max(d.x, d.y), 0.0));

    if (alpha > 0.004) {
        fragColor = mix(fragColor, vec4(1.0), alpha);
    }
}
