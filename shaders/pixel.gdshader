shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;

uniform int pixel_size : hint_range(1, 64) = 4; // Pixel size
uniform vec2 screen_size = vec2(1920.0, 1080.0); // Screen size (set manually)

void fragment() {
    // Work entirely in UV space (0-1)
    vec2 uv = SCREEN_UV;

    // Convert UV to pixel coordinates
    vec2 pixel_coords = uv * screen_size;

    // Quantize to pixel grid
    vec2 quantized_coords = floor(pixel_coords / float(pixel_size)) * float(pixel_size);

    // Add half pixel offset to sample from center of pixel block
    quantized_coords += float(pixel_size) * 0.5;

    // Convert back to UV space
    vec2 final_uv = quantized_coords / screen_size;

    // Sample the screen texture
    COLOR = texture(SCREEN_TEXTURE, final_uv);
}