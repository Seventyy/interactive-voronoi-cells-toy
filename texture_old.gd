extends TextureRect

@export var image_size:Vector2i
@export var point_amount:int

#var cells:Array[Vector2]
var cells:Array[Cell]
var image:Image

class Cell:
	var pos:Vector2
	var weight:float

func _ready() -> void:
	image = Image.create_empty(
		image_size.x, image_size.y, false, Image.FORMAT_RGBA8)
	
	reset_cells()
	clear_image()
	#draw_cells()
	set_image()

func reset_cells() -> void:
	for i in point_amount:
		#cell = Vector2(randf_range(0, size.x), randf_range(0, size.y))
		var cell:Cell = Cell.new()
		cell.pos = Vector2(randf_range(0, size.x), randf_range(0, size.y))
		cell.weight = 1
		cells.append(cell)

func clear_image():
	for i in image_size.x:
		for j in image_size.y:
			image.set_pixelv(Vector2i(i, j), Color.BLACK)

func set_image():
	texture = ImageTexture.create_from_image(image)

func _process(delta: float) -> void:
	var mouse_position:Vector2 = (get_viewport().get_mouse_position() - 
		get_viewport_rect().size / 2 +
		Vector2(image.get_size() / 2))
	
	#material.set("shader_parameter/positions", cells)

func draw_cells() -> void:
	var dist:float
	
	for x in image_size.x:
		for y in image_size.y:
			dist = 999999999999
			for cell in cells:
				dist = min(
					dist, Vector2(x, y).distance_to(cell.pos)
				)
				image.set_pixel(x, y, Color.from_hsv(0,0, dist / size.x))
	
	#COLOR = vec4(vec3(dist / inverse_multiplier), 1.);
	#//COLOR = vec4(vec3(dist / 9999999.), 1.);



#func scatter_points():
	#var undo_redo = Engine.get_singleton(&"EditorInterface").get_editor_undo_redo()
	#undo_redo.create_action("Scattered Points")
	#undo_redo.add_do_property(self, &"cells", 
		#func(point_amount): return range(point_amount)\
		#.map(func(): var cell = Cell.new(); cell.pos = Vector2(
			#randf_range(-image_size.x/2, image_size.x/2),
			#randf_range(-image_size.y/2, image_size.y/2));\
			#return cell)
	#)
	#undo_redo.add_undo_property(self, &"cells", cells)
	#undo_redo.commit_action()
