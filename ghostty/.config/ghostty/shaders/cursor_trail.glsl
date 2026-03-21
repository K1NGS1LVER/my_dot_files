#version 450

layout(location = 0) out vec4 fragColor;

uniform float iTime;
uniform vec3 iResolution;
uniform sampler2D iChannel0;
uniform vec2 iCursor;

void main() {
    vec2 fragCoord = gl_FragCoord.xy;
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);
    float dist = distance(fragCoord, iCursor);
    float liquid = exp(-dist * 0.15);
    vec3 coreColor = vec3(0.96, 0.86, 0.84);
    vec3 edgeColor = vec3(0.78, 0.63, 0.96);
    vec3 finalTrail = mix(edgeColor, coreColor, liquid * 0.5);
    fragColor = mix(terminalColor, vec4(finalTrail, 1.0), liquid * 0.6);
}
