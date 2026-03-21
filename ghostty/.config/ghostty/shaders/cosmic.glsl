const float SEED = 69.42; 
const vec3 COEFFS = fract((SEED + 23.4567) * vec3(0.8191725133961645, 0.6710436067037893, 0.5497004779019703)) + 0.5;
const vec3 SECTION = fract(COEFFS.zxy - COEFFS.yzx * 1.618);

vec3 bas( vec3 x ) {
    vec3 i = floor(x);
    vec3 f = fract(x);
    vec3 s = sign(fract(x/2.0)-0.5);
    vec3 k = fract(SECTION * i + i.yzx);
    return s*f*(f-1.0)*((16.0*k-4.0)*f*(f-1.0)-1.0);
}

vec3 swayRandomized(vec3 seed, vec3 value) {
    return bas(seed.xyz + value.zxy - bas(seed.zxy + value.yzx) + bas(seed.yzx + value.xyz));
}

vec3 cosmic(vec3 c, vec3 con) {
    return (con + swayRandomized(c, con)) * 0.5;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv_norm = fragCoord / iResolution.xy;
    vec4 terminalText = texture(iChannel0, uv_norm);
    vec2 uv = (fragCoord * 0.1) + swayRandomized(COEFFS.zxy, (iTime * 0.05) * COEFFS.yzx - fragCoord.yxy * 0.004).xy * 42.0;
    float aTime = iTime * 0.02;
    vec3 adj = vec3(-1.11, 1.41, 1.61);
    vec3 s = (swayRandomized(vec3(34.0, 76.0, 59.0), aTime + adj)) * 0.25;
    vec3 c = (swayRandomized(vec3(27.0, 67.0, 45.0), aTime - adj.yzx)) * 0.25;
    vec3 con = vec3(0.0004375, 0.0005625, 0.0008125) * aTime + c * uv.x + s * uv.y;
    con = cosmic(COEFFS, con);
    con = cosmic(COEFFS + 1.618, con);
    vec3 cosmicColor = sin(con * 3.1416) * 0.5 + 0.5;
    float textLuma = dot(terminalText.rgb, vec3(0.2126, 0.7152, 0.0722));
    if (textLuma < 0.1) {
        fragColor = vec4(cosmicColor, 1.0);
    } else {
        fragColor = terminalText + vec4(cosmicColor * 0.15, 0.0);
    }
}
