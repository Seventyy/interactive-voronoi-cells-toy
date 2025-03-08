extends Node

@onready var chunk_manager: ChunkManager = %ChunkManager

func _on_texture_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT):
			for point in chunk_manager.get_chunk(event.position).points:
				chunk_manager.remove_point(point)
				chunk_manager.chunkate_point(point)
