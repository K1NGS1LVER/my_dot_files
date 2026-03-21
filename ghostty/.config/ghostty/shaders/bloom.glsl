void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 baseColor = texture(iChannel0, uv);
    
    float threshold = 0.2;
    float strength = 0.6;
    float radius = 0.003;
    
    vec3 bloom = vec3(0.0);
    float totalWeight = 0.0;
    
    float weights[3] = float[](0.227027, 0.316216, 0.070270);
    
    bloom += baseColor.rgb * weights[0];
    totalWeight += weights[0];
    
    for(int i=1; i<3; i++) {
        float offset = float(i) * radius;
        vec3 s1 = texture(iChannel0, uv + vec2(offset, 0.0)).rgb;
        vec3 s2 = texture(iChannel0, uv - vec2(offset, 0.0)).rgb;
        vec3 s3 = texture(iChannel0, uv + vec2(0.0, offset)).rgb;
        vec3 s4 = texture(iChannel0, uv - vec2(0.0, offset)).rgb;
        float w = weights[i];
        if(dot(s1, vec3(0.299, 0.587, 0.114)) > threshold) { bloom += s1 * w; totalWeight += w; }
        if(dot(s2, vec3(0.299, 0.587, 0.114)) > threshold) { bloom += s2 * w; totalWeight += w; }
        if(dot(s3, vec3(0.299, 0.587, 0.114)) > threshold) { bloom += s3 * w; totalWeight += w; }
        if(dot(s4, vec3(0.299, 0.587, 0.114)) > threshold) { bloom += s4 * w; totalWeight += w; }
    }
    
    if (totalWeight > 0.0) {
        bloom /= totalWeight;
    }
    
    fragColor = vec4(baseColor.rgb + (bloom * strength), baseColor.a);
}
