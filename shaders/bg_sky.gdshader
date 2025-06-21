shader_type canvas_item;

uniform vec4 sky_color_top : source_color = vec4(0.4, 0.7, 1.0, 1.0);
uniform vec4 sky_color_bottom : source_color = vec4(0.8, 0.9, 1.0, 1.0);
uniform vec4 cloud_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float cloud_coverage : hint_range(0.0, 1.0) = 0.4;
uniform float cloud_speed : hint_range(0.0, 2.0) = 0.3;
uniform float cloud_scale : hint_range(1.0, 100.0) = 6.0;
uniform float pixelation : hint_range(1.0, 128.0) = 32.0;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    
    return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
    vec2 uv = UV;

    vec3 sky = mix(sky_color_bottom.rgb, sky_color_top.rgb, uv.y);

    vec2 pixel_uv = floor(uv * pixelation) / pixelation;

    vec2 cloud_uv = pixel_uv * cloud_scale;
    cloud_uv.x += TIME * cloud_speed;

    float cloud_noise = noise(cloud_uv);
    float clouds = smoothstep(cloud_coverage, cloud_coverage + 0.3, cloud_noise);

    vec3 final_color = mix(sky, cloud_color.rgb, clouds);
    COLOR = vec4(final_color, 1.0);
}
