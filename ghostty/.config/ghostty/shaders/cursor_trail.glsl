// Ghostty Cursor Trail Shader
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);

    // Ghostty provides iCursor for the cursor position (in pixels)
    float dist = distance(fragCoord, iCursor);
    
    // Create a subtle glow effect around the cursor
    // This provides visual "inbetween" feedback as the cursor moves
    float trail = smoothstep(15.0, 0.0, dist);
    vec3 trailColor = vec3(0.78, 0.63, 0.96); // Catppuccin Mauve
    
    fragColor = mix(terminalColor, vec4(trailColor, 1.0), trail * 0.4);
}
