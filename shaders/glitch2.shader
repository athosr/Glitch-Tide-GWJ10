shader_type canvas_item;

uniform vec3 color = vec3(.33, .15, .82);

float rand(vec2 coord){
	return fract(sin(dot(coord, vec2(56, 78)) * 15000.0) * 1500.0);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1., 0.));
	float c = rand(i + vec2(0., 1.));
	float d = rand(i + vec2(1., 1.));
	
	vec2 cubic = f*10.;
	// Linear Interpolation
	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1. - cubic.x) + (d - b) * cubic.x * cubic.y;
}

void fragment(){
	vec2 coord = UV * 20.0;
	COLOR = vec4(color, noise(coord/10. * TIME));
}