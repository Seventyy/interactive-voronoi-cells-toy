extends TextureRect


func update_shader_parameters():
	#var positions:PackedVector2Array = \
		#points.map(func(point:Cell) -> Vector2: return point.pos / Vector2(image_size))
	#material.set_shader_parameter(&"positions", positions)
	material.set_shader_parameter(&"points", get_points_vec4())


func get_points_vec4() -> PackedVector4Array:
	var unchunkated_points:Array[Vector2] = points
	var chunkated_points:Array[Vector4]
	
	for y in IMAGE_SIZE.y/CHUNK_SIZE:
		for x in IMAGE_SIZE.x/CHUNK_SIZE:
			var rect:Rect2i = Rect2i(Vector2i(x,y) * CHUNK_SIZE, Vector2i.ONE * CHUNK_SIZE)
			for point in unchunkated_points:
				if rect.has_point(point):
					chunkated_points.append(Vector4(
						x, y, point.x/IMAGE_SIZE.x, point.y/IMAGE_SIZE.y))
					unchunkated_points.erase(point)
	
	for point in chunkated_points:
		print(point)
	
	return PackedVector4Array(chunkated_points)


func get_points_texture():
	var image:Image = Image.new()
	image = image.create_empty(points.size(), 1, false, Image.FORMAT_RG8)
	for i in points.size():
		image.set_pixelv(Vector2i.RIGHT * i, Color8(
			remap(points[i].x, 0, IMAGE_SIZE.x, 0, 256),
			remap(points[i].y, 0, IMAGE_SIZE.y, 0, 256),
			0 
		))
	var points_texture:ImageTexture = ImageTexture.new()
	points_texture = points_texture.create_from_image(image)
	
	#for i in 10:
		#print(image.get_pixel(i, 0))
	#print("---")
	
	return points_texture
