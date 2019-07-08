extends "res://labz/lab.gd"

onready var textbox = get_node("hsc/text/TextEdit")
onready var prepend = get_node("hsc/vbc/modifiers/custom/prepend/TextEdit")
onready var append = get_node("hsc/vbc/modifiers/custom/append/TextEdit")

onready var spinparent = get_node("hsc/vbc/modifiers/paintballz/HBoxContainer/spinparent")
onready var spinsize = get_node("hsc/vbc/modifiers/paintballz/HBoxContainer/spinsize")

onready var spinroll = get_node("hsc/vbc/vbc/hbc/vbc/spinroll")
onready var spinpitch = get_node("hsc/vbc/vbc/hbc/vbc/spinpitch")
onready var spinyaw = get_node("hsc/vbc/vbc/hbc/vbc/spinyaw")

onready var inputPNG = get_node("hsc/vbc/vbc/hbc/inputPNG")

onready var checkspherise = find_node("checkspherise")
onready var spinspace = find_node("spinspace")

var img = load("res://icon.png").get_data()


func _ready():
	img_to_ball_grid()
	#parse_chart()
	#save_chart()
	


func sphere_elevation(size : Vector2):
	#hey it makes a spherey bump array thing
	#dunno wtf it would do on a rectangle
	var elevation_map = []
	for u in size.x:
		var y = sqrt(pow(0.5,2)-pow(( ( (u+0.5)/size.x) -0.5),2))
		elevation_map.append([])
		for v in size.y:
			var x = sqrt(pow(0.5,2)-pow(( ( (v+0.5)/size.y) -0.5),2))
			elevation_map[u].append( -(x*y*2) )
		
	
	return elevation_map


func img_to_ball_grid():
	if inputPNG.texture == null:
		return
	img = inputPNG.texture.get_data()
	img.lock()
	var bxy_array = []
	var bxy_string = ""
	var bxy_space = int(spinspace.get_line_edit().text)
	var bxy_size = img.get_size()
	
	var elmap = sphere_elevation(bxy_size)
	#print(elmap.size())
	
	for y in bxy_size.y:
		bxy_array.append([])
		for x in bxy_size.x:
			if img.get_pixel(x,y).a == 1:
				bxy_array[y].append( Global.color_chart.find(img.get_pixel(x,y).to_html(false)) )
			else:
				bxy_array[y].append(-1)
	
	for y in bxy_array.size():
		for x in bxy_array[y].size():
			if bxy_array[y][x] != -1:
				
				if checkspherise.pressed:
					
					var dir = Vector3( (x-bxy_size.x/2)*bxy_space, (y-bxy_size.y/2)*bxy_space, elmap[x][y]*bxy_space*bxy_size.x)
					#get text because value only updates upon evaluation
					#if someone clicks a button directly from editing then the values wont be updated
					dir = rotate_vec3(dir, float(spinroll.get_line_edit().text), float(spinpitch.get_line_edit().text), float(spinyaw.get_line_edit().text))
					
					bxy_string += str(dir.x,", ",dir.y,", ",dir.z,", ") + str(bxy_array[y][x]) + "\n"
				else:
					#some duplicated code here, could be reduced
					
					var dir = Vector3( (x-bxy_size.x/2)*bxy_space, (y-bxy_size.y/2)*bxy_space, 0)
					#get text because value only updates upon evaluation
					#if someone clicks a button directly from editing then the values wont be updated
					dir = rotate_vec3(dir, float(spinroll.get_line_edit().text), float(spinpitch.get_line_edit().text), float(spinyaw.get_line_edit().text))
					
					bxy_string += str(round(dir.x),", ",round(dir.y),", ",round(dir.z),", ") + str(bxy_array[y][x]) + "\n"
	
	textbox.text = bxy_string.trim_suffix("\n")



func _on_wrapButton_pressed():
#	var new_string = ""
#	for line in textbox.get_line_count():
#		new_string += prepend.text + textbox.get_line(line) + append.text + "\n"
#	textbox.text = new_string
	textbox.text = wrap_text_lines(textbox.text, prepend.text, append.text)
	


func _on_convertButton_down():
	img_to_ball_grid()


func _on_paintballzButton_pressed():
	var new_string = ""
	for line in textbox.get_line_count():
		new_string += str(spinparent.get_line_edit().text,", ",spinsize.get_line_edit().text,", ") + textbox.get_line(line) + ", -1, 0, -1, -1, -1, 0" + "\n"
	textbox.text = new_string
	
