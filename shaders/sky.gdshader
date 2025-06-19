shader_type canvas_item;

uniform vec3 sky_color = vec3(0.4, 0.7, 1.0);
uniform float cloud_density = 0.5;
uniform float pixel_size = 64.0;
uniform float cloud_amount = 10.0;
uniform bool animate_clouds = false;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

float clumpy_noise(vec2 uv) {
    float n = 0.0;
    n += rand(floor(uv));
    n += rand(floor(uv + vec2(1.0, 0.0)));
    n += rand(floor(uv + vec2(0.0, 1.0)));
    n += rand(floor(uv + vec2(-1.0, 0.0)));
    n += rand(floor(uv + vec2(0.0, -1.0)));
    n /= 5.0;
    return n;
}

void fragment() {
    vec2 pixel_uv = floor(UV * pixel_size) / pixel_size;
    vec2 noise_uv = pixel_uv * cloud_amount;
    float time = TIME;
    if (animate_clouds) {
        noise_uv.x += time * 0.05;
    }
    float noise = clumpy_noise(noise_uv);
    float cloud = step(cloud_density, noise);
    vec3 final_color = mix(sky_color, vec3(1.0), cloud * 0.7);
    COLOR = vec4(final_color, 1.0);
}
