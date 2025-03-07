shader_type canvas_item;

const int amount = 3;

uniform float inverse_multiplier;
uniform vec2[amount] positions;

void fragment() {
	float dist = 999999.;
	
	for (int i = 0; i < amount; i++) {
		for (int j = 0; j < amount; j++) {
			if(i == j) continue;
			dist = min(
				dist, sqrt(
				pow(positions[i].x - positions[j].x, 2.) + 
				pow(positions[i].y - positions[j].y, 2.)) 
			);
		}
	}
	
	COLOR = vec4(vec3(dist / inverse_multiplier), 1.);
	//COLOR = vec4(vec3(dist / 9999999.), 1.);
}
