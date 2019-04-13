extends Control

onready var textbox = get_node("hsc/text/TextEdit")
onready var prepend = get_node("hsc/vbc/modifiers/custom/prepend/TextEdit")
onready var append = get_node("hsc/vbc/modifiers/custom/append/TextEdit")

onready var spinparent = get_node("hsc/vbc/modifiers/paintballz/HBoxContainer/spinparent")
onready var spinsize = get_node("hsc/vbc/modifiers/paintballz/HBoxContainer/spinsize")

onready var spinroll = get_node("hsc/vbc/vbc/hbc/vbc/spinroll")
onready var spinpitch = get_node("hsc/vbc/vbc/hbc/vbc/spinpitch")
onready var spinyaw = get_node("hsc/vbc/vbc/hbc/vbc/spinyaw")

onready var inputPNG = get_node("hsc/vbc/vbc/hbc/inputPNG")
onready var spinspace = get_node("hsc/vbc/vbc/hbc/spinspace")

var img = load("res://icon.png").get_data()
var colchart = load("res://palette/ColorChart.png").get_data()

var paintballz = true

func _ready():
	img_to_addball_grid()
	#parse_chart()
	#save_chart()
	

func parse_chart():
	colchart.lock()
	var colarray = []
	
	var x_space = 28
	var x_offset = 8
	var y_space = 23
	var y_offset = 25
	
	for y in 16:
		for x in 16:
			colarray.append("\""+colchart.get_pixel( (x*x_space)+x_offset, (y*y_space)+y_offset ).to_html(false)+"\"" )
	
	textbox.text = str(colarray)

func save_chart():
	var palimg = Image.new()
	palimg.create( 16, 16, false, Image.FORMAT_RGB8 )
	palimg.lock()
	
	for y in 16:
		for x in 16:
			palimg.set_pixel(x,y, Color(Global.color_chart[x+y*16]) )
	
	palimg.save_png("res://petzpalette.png")
	

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


func img_to_addball_grid():
	if inputPNG.texture == null:
		return
	img = inputPNG.texture.get_data()
	img.lock()
	var bxy_array = []
	var bxy_string = ""
	var bxy_space = int(spinspace.get_line_edit().text)
	var bxy_size = img.get_size()
	
	var elmap = sphere_elevation(bxy_size)
	print(elmap.size())
	
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
				#give option for zero z
				# also gotta implement rotation somewhere????
				var dir = Vector3( (x-bxy_size.x/2)*bxy_space, (y-bxy_size.y/2)*bxy_space, elmap[x][y]*bxy_space*bxy_size.x)
				dir = rotate_vec3(dir)
				
				if paintballz:
					#well this just works. thats cool
					bxy_string += str(dir.x,", ",dir.y,", ",dir.z,", ") + str(bxy_array[y][x]) + "\n"
				else:
					#retool this one for addballz, no difference yet
					bxy_string += str(dir.x,", ",dir.y,", ",dir.z,", ") + str(bxy_array[y][x]) + "\n"
	
	textbox.text = bxy_string.trim_suffix("\n")

func rotate_vec3(vec : Vector3):
	#use this basis for some reason
	var basis = Basis( Vector3(1,0,0), Vector3(0,1,0), Vector3(0,0,1))
	
	#get text because value only updates upon evaluation
	#if someone clicks a button directly from editing then the values wont be updated
	var roll = spinroll.get_line_edit().text
	var pitch = spinpitch.get_line_edit().text
	var yaw = spinyaw.get_line_edit().text
	
	var rotation = Vector3(deg2rad(pitch),deg2rad(yaw),deg2rad(roll))
	print( rotation.y)
	# roll > pitch > yaw
	vec = vec.rotated( basis.z, rotation.z )
	vec = vec.rotated( basis.x, rotation.x )
	vec = vec.rotated( basis.y, rotation.y )
	
	return vec

func _on_wrapButton_pressed():
	var new_string = ""
	for line in textbox.get_line_count():
		new_string += prepend.text + textbox.get_line(line) + append.text + "\n"
		#textbox.get_line(line)
		#pass
	textbox.text = new_string


func _on_convertButton_down():
	img_to_addball_grid()


func _on_paintballzButton_pressed():
	var new_string = ""
	for line in textbox.get_line_count():
		new_string += str(spinparent.get_line_edit().text,", ",spinsize.get_line_edit().text,", ") + textbox.get_line(line) + ", -1, 0, -1, -1, -1, 0" + "\n"
		#textbox.get_line(line)
		#pass
	textbox.text = new_string
	
