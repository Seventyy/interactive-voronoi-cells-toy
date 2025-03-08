extends Node

@onready var chunk_manager: ChunkManager = %ChunkManager
@onready var texture: TextureRect = %Texture

func _process(_delta: float) -> void:
	if (Input.is_action_pressed("ui_down")):
		for i in chunk_manager.points.size():
			if chunk_manager.points[i].y < chunk_manager.IMAGE_SIZE - 1:
				chunk_manager.points[i].y += 1
			else:
				chunk_manager.points[i].x = randi_range(0, chunk_manager.IMAGE_SIZE - 1)
				chunk_manager.points[i].y = 0
		chunk_manager.chunkate_all()
		texture.update_shader_parameters()
