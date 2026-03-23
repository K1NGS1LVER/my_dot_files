void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 base = texture(iChannel0, uv);
    // Pseudo-random noise generation
    float noise = (fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * 0.02;
    fragColor = vec4(base.rgb + noise, base.a);
}
