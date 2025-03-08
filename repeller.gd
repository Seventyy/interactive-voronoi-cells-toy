extends Node

@onready var chunk_manager: ChunkManager = %ChunkManager
@onready var texture: TextureRect = %Texture
#
#func _on_texture_gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and\
	#Rect2i(Vector2i.ZERO, Vector2i.ONE * chunk_manager.IMAGE_SIZE).has_point(event.position):
		#for i in range(-1, 2):
			#for j in range(-1, 2):
				#for point in chunk_manager.get_chunk(event.position).points:
					#chunk_manager.remove_point(point)
					#chunk_manager.chunkate_point(Vector2i(
						#randi_range(0, chunk_manager.IMAGE_SIZE - 1),
						#randi_range(0, chunk_manager.IMAGE_SIZE - 1)
					#))
				#texture.update_shader_parameters()
