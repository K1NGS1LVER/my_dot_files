void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 terminalText = texture(iChannel0, uv);
    
    vec2 st = uv;
    st.y -= 0.5;
    st.x *= iResolution.x / iResolution.y;
    
    float time = iTime * 0.2;
    vec3 aurora = vec3(0.0);
    
    // Optimized Aurora layers
    for (float i = 0.0; i < 3.0; i++) {
        float y_offset = sin(st.x * (1.5 + i) + time * (1.0 + i)) * 0.2;
        float curtain = 0.01 / abs(st.y + y_offset + (i * 0.05));
        
        // Classic Aurora Colors: Neon Green -> Deep Purple
        vec3 col = mix(vec3(0.1, 1.0, 0.4), vec3(0.5, 0.0, 1.0), i / 3.0);
        aurora += curtain * col;
    }

    float streaks = sin(st.x * 50.0 + time * 5.0) * 0.1 + 0.9;
    aurora *= streaks;
    
    vec3 sky = vec3(0.02, 0.02, 0.05);
    vec3 finalBackground = sky + aurora * 0.5;

    float textLuma = dot(terminalText.rgb, vec3(0.2126, 0.7152, 0.0722));
    if (textLuma < 0.1) {
        fragColor = vec4(finalBackground, 1.0);
    } else {
        fragColor = terminalText + vec4(aurora * 0.1, 0.0);
    }
}
