extends TextureRect

var mouse_over = false

func _ready():
	get_tree().connect("files_dropped", self, "_files_dropped")


func _files_dropped(files, screen):
	print("dropped")
	
	#wait a moment to make sure the global mouse updates
	yield(get_tree().create_timer(0.1), "timeout")
	
	#print(get_global_mouse_position())
	if get_global_rect().has_point(get_global_mouse_position()):
		print("inside rect")
		var maybe_img = load_png(files[0])
		
		#remove filter flag
		maybe_img.flags -= 4
		texture = maybe_img
		update()
	


func load_png(file):
	var png_file = File.new()
	png_file.open(file, File.READ)
	var bytes = png_file.get_buffer(png_file.get_len())
	var img = Image.new()
	var data = img.load_png_from_buffer(bytes)
	var imgtex = ImageTexture.new()
	imgtex.create_from_image(img)
	png_file.close()
	return imgtex