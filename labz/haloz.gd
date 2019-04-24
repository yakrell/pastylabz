extends "res://labz/lab.gd"

onready var spinbase = find_node("spinbase")
onready var spindist = find_node("spindist")
onready var spinroll = find_node("spinroll")
onready var spinpitch = find_node("spinpitch")
onready var spinyaw = find_node("spinyaw")
onready var spinbsize = find_node("spinbsize")
onready var spinrsize = find_node("spinrsize")
onready var spinreso = find_node("spinreso")
onready var spinbcolor = find_node("spinbcolor")

onready var spinstart = find_node("spinstart")

onready var outputaddballz = find_node("outputaddballz")
onready var outputlinez = find_node("outputlinez")

func _ready():
	pass
	


func _on_ringButton_pressed():
	var reso = int( spinreso.get_line_edit().text )
	var base = spinbase.get_line_edit().text
	var bcolor = spinbcolor.get_line_edit().text
	var bsize = spinbsize.get_line_edit().text
	var rsize = int(spinrsize.get_line_edit().text)/2 #divide by 2 for radius
	var dist = int(spindist.get_line_edit().text)
	
	var angle = deg2rad(360/reso)
	
	var addballz = ""
	for i in range(reso):
		var dir = Vector3(cos(i*angle)*rsize, sin(i*angle)*rsize, dist)
		#add 90 to the roll so triangles are more intuitive (point at bottom on 0 roll)
		var circpoint = rotate_vec3(dir, float(spinroll.get_line_edit().text)+90, float(spinpitch.get_line_edit().text), float(spinyaw.get_line_edit().text))
		var vec = Vector3(round(circpoint.x),round(circpoint.y),round(circpoint.z))
		
		#base x y z color otlnCol spckCol fuzz group outline ballsize bodyarea addGroup texture 
		addballz += str(base,", ",vec.x,", ",vec.y,", ",vec.z,", ",bcolor,", 0, 0, 0, -1, -1, ",bsize,", 0, 0, -1") + "\n"
	
	outputaddballz.text = addballz.trim_suffix("\n")


func _on_linezButton_pressed():
	var reso = int( spinreso.get_line_edit().text )
	var bcolor = spinbcolor.get_line_edit().text
	var start = int( spinstart.get_line_edit().text )
	
	var linez = ""
	for i in range(reso-1):
		#srt end fuzz col lfCol rtCol sThck eThick
		linez += str(start+i, ", ", start+i+1, ", 0, -1, -1, -1, 100, 100") + "\n"
	#link to start ball to complete loop
	linez += str(start+reso-1, ", ", start, ", 0, -1, -1, -1, 100, 100")
	
	outputlinez.text = linez
