shader_type canvas_item;

uniform int OCTAVES = 6;

float rand(vec2 coord){
	return fract(sin(dot(coord, vec2(12.9898, 78.233))) * 43758.5453123);
}

float noise(vec2 coord){
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1., 0.));
	float c = rand(i + vec2(0., 1.));
	float d = rand(i + vec2(1., 1.));
	
	vec2 cubic = f * f * (3. - 2. * f);
	// Linear Interpolation
	//return mix(a, b, f.x) + (c - a) * f.y * (1. - f.x) + (d - b) * f.x * f.y;
	// Cubic Interpolation
	return mix(a, b, cubic.x) + (c - a) * cubic.y * (1. - cubic.x) + (d - b) * cubic.x * cubic.y;
}

float fbm(vec2 coord){
	float value = .0;
	float scale = .5;
	
	for(int i = 0; i < OCTAVES; i++){
		value += noise(coord) * scale;
		coord *= 2.;
		scale *= .5;
	}
	return value;
}

void fragment(){
	vec4 tex = textureLod(TEXTURE, UV, .0);
	
	float noise = fbm(UV * float(99));
	
	COLOR.rgb = tex.rgb * (noise * abs(sin(TIME)*5.) + .5);
}