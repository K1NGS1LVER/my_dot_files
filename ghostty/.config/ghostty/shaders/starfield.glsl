const float threshold = 0.15;
const float repeats = 30.0;
const float layers = 21.0;

const vec3 blue = vec3(51., 64., 195.) / 255.;
const vec3 cyan = vec3(117., 250., 254.) / 255.;
const vec3 white = vec3(255., 255., 255.) / 255.;
const vec3 yellow = vec3(251., 245., 44.) / 255.;
const vec3 red = vec3(247, 2., 20.) / 255.;

float luminance(vec3 color) { return dot(color, vec3(0.2126, 0.7152, 0.0722)); }

vec3 spectrum(vec2 pos) {
    pos.x *= 4.0;
    vec3 outCol = vec3(0);
    if (pos.x > 0.) outCol = mix(blue, cyan, fract(pos.x));
    if (pos.x > 1.) outCol = mix(cyan, white, fract(pos.x));
    if (pos.x > 2.) outCol = mix(white, yellow, fract(pos.x));
    if (pos.x > 3.) outCol = mix(yellow, red, fract(pos.x));
    return 1. - (pos.y * (1. - outCol));
}

float N21(vec2 p) {
    p = fract(p * vec2(233.34, 851.73));
    p += dot(p, p + 23.45);
    return fract(p.x * p.y);
}

vec2 N22(vec2 p) {
    float n = N21(p);
    return vec2(n, N21(p + n));
}

vec3 stars(vec2 uv, float offset) {
    float timeScale = -(iTime * 0.05 + offset) / layers;
    float trans = fract(timeScale);
    float newRnd = floor(timeScale);
    vec2 st = (uv - 0.5) * trans + 0.5;
    st.x *= iResolution.x / iResolution.y;
    st *= repeats;
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);
    vec2 rndXY = N22(newRnd + ipos * (offset + 1.)) * 0.9 + 0.05;
    float dist = distance(fpos, rndXY);
    float sparkle = smoothstep(0.015, 0.0, dist);
    vec3 col = spectrum(fract(rndXY * newRnd * ipos)) * sparkle;
    return col * smoothstep(1.0, 0.8, trans);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);
    vec3 col = vec3(0.0);
    for (float i = 0.0; i < layers; i++) {
        col += stars(uv, i);
    }
    float mask = 1.0 - step(threshold, luminance(terminalColor.rgb));
    vec3 blendedColor = mix(terminalColor.rgb, col, mask);
    fragColor = vec4(blendedColor, terminalColor.a);
}
