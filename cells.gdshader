shader_type canvas_item;

const int AMOUNT = 10;

uniform float threshold = .1;
uniform vec2[AMOUNT] positions;

void fragment() {
	for(int i = 0; i < AMOUNT; i++){
		vec2 diff_vec = vec2(UV.x - positions[i].x, UV.y - positions[i].y);
		if(diff_vec.x * diff_vec.x + diff_vec.y * diff_vec.y < threshold){
			COLOR = vec4(1);
		}
	}
}

void vorinoi(){
	float dist = 999999.;
	
	for (int i = 0; i < AMOUNT; i++) {
		for (int j = 0; j < AMOUNT; j++) {
			if(i == j) continue;
			dist = min(
				dist, sqrt(
				pow(positions[i].x - positions[j].x, 2.) + 
				pow(positions[i].y - positions[j].y, 2.)) 
			);
		}
	}
}