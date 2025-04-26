shader_type canvas_item;

uniform float distort_scale = 20.;
uniform sampler2D distort_texture : repeat_disable, filter_linear;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_linear_mipmap;

void fragment() {
	vec2 uv = SCREEN_UV / SCREEN_PIXEL_SIZE;
	vec2 distort = textureLod(distort_texture, SCREEN_UV, 0.0).xy;
	distort = (distort - .5)*distort_scale;
	if(length(distort) > 1.){
		uv += distort;
	}
	COLOR = textureLod(screen_texture, uv * SCREEN_PIXEL_SIZE, 0.0);
}
