class_name ChunkManager extends Node

@onready var texture: TextureRect = %Texture

const CHUNK_SIZE:int = 64
const IMAGE_SIZE:int = 512
const CHUNK_COUNT:int = IMAGE_SIZE / CHUNK_SIZE # in one axis
const POINT_AMOUNT:int = 100

var points:Array[Vector2]
var chunks:Dictionary[Vector2i, Chunk]

class Chunk:
	var points:Array[Vector2i]


func chunkate_all(unchunkated_points:Array[Vector2i]) -> void:
	var chunkated_points:Array[Vector2i]
	
	for y in CHUNK_COUNT:
		for x in CHUNK_COUNT:
			var rect:Rect2i = Rect2i(Vector2i(x,y) * CHUNK_SIZE, Vector2i.ONE * CHUNK_SIZE)
			for point in unchunkated_points:
				if rect.has_point(point):
					chunks[Vector2i(x,y)].points.append(Vector2i(point.x, point.y))
					unchunkated_points.erase(point)


func initialise_chunks() -> void:
	chunks.clear()
	for y in CHUNK_COUNT:
		for x in CHUNK_COUNT:
			chunks[Vector2i(x,y)] = Chunk.new()


func remove_point(point:Vector2i) -> void:
	chunks[point / CHUNK_SIZE].points.erase(point)


func chunkate_point(point:Vector2i) -> void:
	chunks[point / CHUNK_SIZE].points.append(point)


func get_chunk(position:Vector2) -> Chunk:
	return chunks[Vector2i(position / CHUNK_SIZE)]


func _ready() -> void:
	initialise_chunks()
	var points:Array[Vector2i]
	for point in texture.points:
		points.append(Vector2i(point))
	chunkate_all(points)
