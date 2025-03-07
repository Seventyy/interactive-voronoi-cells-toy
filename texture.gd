@tool
extends TextureRect

@export_tool_button("Scatter Points") 
var scatter_points_action = scatter_points

@export_tool_button("Update Shader Parameters") 
var update_shader_parameters_action = update_shader_parameters

@export var image_size:Vector2i
@export var point_amount:int = 10

var cells:Array[Cell]

class Cell:
	var pos:Vector2


func scatter_points():
	cells.clear()
	for i in point_amount:
		var cell:Cell = Cell.new()
		cell.pos =  Vector2(
			randf_range(0, image_size.x),
			randf_range(0, image_size.y)
		)
		cells.append(cell)
	update_shader_parameters()


func update_shader_parameters():
	var positions:PackedVector2Array = \
		cells.map(func(cell:Cell) -> Vector2: return cell.pos / Vector2(image_size))
	material.set_shader_parameter(&"positions", positions)
