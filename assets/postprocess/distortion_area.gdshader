shader_type canvas_item;

uniform vec2 distort = vec2(1.,0.);
uniform vec2 distort_center = vec2(.5,.5);
uniform float area_scale_fac = 10;
uniform float cutoff = .1;

void fragment() {
	vec2 diff = UV - distort_center;
	float d = dot(diff, diff) / area_scale_fac;

	float influence = max(1. / (1. + d) -.1, 0);

	COLOR = vec4(distort * .5 + .5,1.,influence);
}
