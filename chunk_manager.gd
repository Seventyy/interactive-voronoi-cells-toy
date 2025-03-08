class_name ChunkManager extends Node

@onready var texture: TextureRect = %Texture

const CHUNK_SIZE:int = 64
const IMAGE_SIZE:int = 512
@warning_ignore("integer_division")
const CHUNK_COUNT:int = IMAGE_SIZE / CHUNK_SIZE # in one axis
const POINT_AMOUNT:int = 256

var points:Array[Vector2i]
var chunks:Dictionary[Vector2i, Chunk]

class Chunk:
	var points:Array[Vector2i]


func chunkate_all() -> void:
	initialise_chunks()
	var unchunkated_points:Array[Vector2i] = points.duplicate()
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
	var converted_points:Array[Vector2i]
	for point in converted_points:
		points.append(Vector2i(point))
	chunkate_all()
