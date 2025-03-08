@tool
extends Node

@export_tool_button("Scatter Points") 
var scatter_points_action = scatter_points

@onready var chunk_manager: ChunkManager = %ChunkManager

func scatter_points():
	for i in chunk_manager.POINT_AMOUNT:
		chunk_manager.points.append(Vector2(
			randf_range(0, chunk_manager.IMAGE_SIZE),
			randf_range(0, chunk_manager.IMAGE_SIZE)
		))
