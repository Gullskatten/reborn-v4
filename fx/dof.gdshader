shader_type canvas_item;

uniform float limit: hint_range(0.0, 0.5) = 0.2;
uniform float blur: hint_range(0.0, 5.0) = 1.931;
uniform float intensity: hint_range(0.0, 1.0) = 1.0;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	COLOR = textureLod(SCREEN_TEXTURE, SCREEN_UV, blur);
	float n = abs(sin(SCREEN_UV.y * PI * intensity) - intensity);
	float dist = distance(vec2(0.35, 0.35), vec2(mix(0, -SCREEN_UV.x, 3840.0/2160.0), SCREEN_UV.y * 0.5));
	COLOR.a = smoothstep(0, dist, n);
}