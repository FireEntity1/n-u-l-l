shader_type canvas_item;

uniform sampler2D pixel_texture : hint_default_white;
uniform vec2 screen_size = vec2(128, 128);

void fragment() {
	vec2 uv = UV * screen_size;
	uv -= floor(uv);
	vec4 crt_overlay = texture(pixel_texture, uv);
	vec4 base_texture = texture(TEXTURE, UV);
	COLOR.rgb = crt_overlay.rgb * base_texture.rgb * base_texture.a;
	COLOR.a = 1.;
}