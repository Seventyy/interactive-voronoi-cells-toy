shader_type canvas_item;

#include "res://consts.gdshaderinc"

uniform vec4[POINT_AMOUNT] points;
uniform vec3 backgrond_color : source_color;
uniform vec3 foregrond_color : source_color;
uniform float max_range : hint_range(0, 1) = 1;

uniform float a;
uniform float b;
uniform float c;
uniform float d;

const int CHUNK_COUNT = IMAGE_SIZE / CHUNK_SIZE; // only works for even
const float MAX_DIST = 1./float(CHUNK_COUNT) * 2.;

float remap(float value, float in_min, float in_max, float out_min, float out_max) {
    return mix(out_min, out_max, (value - in_min) / (in_max - in_min));
}

float find_minimum_distance(vec2 uv, ivec2 coords, int extends) {
	float min_dist = MAX_DIST;
	for (int y = coords.y - extends; y <= coords.y + extends; y++) {
		for (int x = coords.x - extends; x <= coords.x + extends; x++) {
			for (int i = 0; i < POINT_AMOUNT; i++) {
				if (int(points[i].x) != x || int(points[i].y) != y) continue;
				min_dist = min(
				min_dist,
				length(points[i].zw - uv)
			);
			}
		}
	}

	return min_dist;
}

void fragment() {
	ivec2 coords = ivec2(UV * float(CHUNK_COUNT)); // chunk coors of current pixel
	//float min_dist = MAX_DIST;
	//for (int i = 1; min_dist == MAX_DIST; i++){ // starting value has to be fit to max range
		//min_dist = find_minimum_distance(UV, coords, i);
	//}
	float min_dist = find_minimum_distance(UV, coords, 1);

	//float new_dist = mix(0, max_range, min_dist / MAX_DIST);
	//float dist_perc = min(min_dist, 1./float(IMAGE_SIZE / CHUNK_SIZE));

	COLOR.rgb = mix(
		backgrond_color, foregrond_color,
		min_dist * a);


}
