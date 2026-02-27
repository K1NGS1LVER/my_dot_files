// Advanced Liquid Cursor Trail for Ghostty
void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalColor = texture(iChannel0, uv);

    // Calculate distance to cursor
    float dist = distance(fragCoord, iCursor);
    
    // Create a "Liquid" smear effect
    // Exponential decay creates a softer, more natural falloff than linear smoothstep
    float liquid = exp(-dist * 0.15); 
    
    // Mix Catppuccin Mauve with a hint of Rosewater for the core
    vec3 coreColor = vec3(0.96, 0.86, 0.84); // Rosewater (#f4dbd6)
    vec3 edgeColor = vec3(0.78, 0.63, 0.96); // Mauve (#c6a0f6)
    
    // Combine the colors for a dynamic glow
    vec3 finalTrail = mix(edgeColor, coreColor, liquid * 0.5);
    
    // Blend the trail with the terminal text
    // Using a 0.6 multiplier for a strong but translucent "afterimage"
    fragColor = mix(terminalColor, vec4(finalTrail, 1.0), liquid * 0.6);
}
