extends Panel

var obj = null

var mouse_over = false
onready var label = get_child(0)

func _ready():
	get_tree().connect("files_dropped", self, "_files_dropped")


func _files_dropped(files, screen):
	print("dropped")
	#print(Array(files[0].split("\\")).back())
	label.text = Array(files[0].split("\\")).back()
	
	#wait a moment to make sure the global mouse updates
	yield(get_tree().create_timer(0.1), "timeout")
	
	#print(get_global_mouse_position())
	if get_global_rect().has_point(get_global_mouse_position()):
		print("inside rect")
		var maybe_obj = load_obj(files[0])
		
		obj = maybe_obj
	


func load_obj(file):
	var obj_file = File.new()
	obj_file.open(file, File.READ)
	
	var obj_array = []
	
	var i = 1
	while not obj_file.eof_reached():
		var line = obj_file.get_line()
		obj_array.append(line)
		i += 1
	
	obj_file.close()
	print(obj_array)
	return obj_array