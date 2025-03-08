shader_type canvas_item;

#include "res://consts.gdshaderinc"

uniform vec4[POINT_AMOUNT] points;
uniform vec3 foregrond_color : source_color;

const vec2 CHUNK_COUNT = IMAGE_SIZE / float(CHUNK_SIZE); // only works for even
const float MAX = 2137.;


float find_minimum_distance(vec2 uv, ivec2 coords, int extends) {
	float minimum_distance = MAX;
	for (int y = coords.y - extends; y <= coords.y + extends; y++) {
		for (int x = coords.x - extends; x <= coords.x + extends; x++) {
			for (int i = 0; i < POINT_AMOUNT; i++) {
				if (int(points[i].x) != x || int(points[i].y) != y) continue;
				minimum_distance = min(
				minimum_distance,
				length(points[i].zw)
			);
			}
		}
	}
	return minimum_distance;
}

void fragment() {
	ivec2 coords = ivec2(UV * CHUNK_COUNT); // chunk coors of current pixel
	COLOR.rgb = foregrond_color * find_minimum_distance(UV, coords, 1);
}
