const float DURATION = 0.4;
const float TRAIL_OPACITY = 0.6;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    // Early exit when animation is done — biggest perf win
    float t = (iTime - iTimeCursorChange) / DURATION;
    if (t >= 1.0) return;
    t = clamp(t, 0.0, 1.0);
    float t2 = t * t;
    float progress = t2 / (2.0 * (t2 - t) + 1.0);

    float rY = iResolution.y;
    vec2 vu = (fragCoord * 2.0 - iResolution.xy) / rY;
    vec2 ccPos = (iCurrentCursor.xy * 2.0 - iResolution.xy) / rY;
    vec2 ccSz = iCurrentCursor.zw * 2.0 / rY;
    vec2 cpPos = (iPreviousCursor.xy * 2.0 - iResolution.xy) / rY;
    vec2 cpSz = iPreviousCursor.zw * 2.0 / rY;

    vec2 head = ccPos + ccSz * vec2(0.5, -0.5);
    vec2 tail = cpPos + cpSz * vec2(0.5, -0.5);

    float cursorHalf = max(ccSz.x, ccSz.y) * 0.5;
    vec2 diff = tail - head;
    float lenSq = dot(diff, diff);

    // Skip short movements (typing, small jumps)
    if (lenSq <= 9.0 * cursorHalf * cursorHalf) return;

    // Retract tail toward head over time (kitty style)
    vec2 curTail = mix(tail, head, progress);
    vec2 ba = curTail - head;
    float baSq = dot(ba, ba);
    if (baSq < 1e-6) return;

    // Capsule SDF — replaces expensive 4-segment parallelogram
    vec2 pa = vu - head;
    float h = clamp(dot(pa, ba) / baSq, 0.0, 1.0);
    float dist = length(pa - ba * h) - cursorHalf;

    // Early exit for pixels far from trail
    float px = 2.0 / rY;
    if (dist > px) return;

    float mask = 1.0 - smoothstep(0.0, px, dist);
    float grad = 1.0 - h;
    grad *= grad;
    float fade = 1.0 - progress;
    fade *= fade;

    // Cursor SDF — don't draw trail over cursor
    vec2 d = abs(vu - head) - ccSz * 0.5;
    float cursorSdf = length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);

    float alpha = mask * grad * fade * TRAIL_OPACITY * step(0.0, cursorSdf);
    fragColor = mix(fragColor, vec4(1.0), alpha);
}
