extends TextureRect

@onready var chunk_manager: ChunkManager = %ChunkManager


func _ready() -> void:
	initialise_texture()
	scatter_points()
	update_shader_parameters()


func initialise_texture() -> void:
	texture = ImageTexture.create_from_image(
		Image.create_empty(
			chunk_manager.IMAGE_SIZE, chunk_manager.IMAGE_SIZE,
			false, Image.FORMAT_RGB8))


func scatter_points() -> void:
	chunk_manager.points.clear()
	for i in chunk_manager.POINT_AMOUNT:
		chunk_manager.points.append(Vector2i(
			randi_range(0, chunk_manager.IMAGE_SIZE - 1),
			randi_range(0, chunk_manager.IMAGE_SIZE - 1)
		))
	chunk_manager.chunkate_all()


func update_shader_parameters() -> void:
	material.set_shader_parameter(&"points", get_points_as_vec4(chunk_manager.points))


func get_points_as_vec4(points:Array[Vector2i]) -> PackedVector4Array:
	var points_as_vec4:Array[Vector4]
	
	for y in chunk_manager.CHUNK_COUNT:
		for x in chunk_manager.CHUNK_COUNT:
			var chunk_points:Array[Vector2i] = chunk_manager.chunks[Vector2i(x,y)].points
			for point in chunk_points:
				points_as_vec4.append(Vector4(
					x,
					y,
					float(point.x)/chunk_manager.IMAGE_SIZE,
					float(point.y)/chunk_manager.IMAGE_SIZE
				))
			
	return PackedVector4Array(points_as_vec4)
