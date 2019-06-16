extends "res://labz/lab.gd"

onready var inputOBJ = find_node("inputOBJ")

onready var outputaddballz = find_node("outputaddballz")
onready var outputlinez = find_node("outputlinez")

onready var spinroll = find_node("spinroll")
onready var spinpitch = find_node("spinpitch")
onready var spinyaw = find_node("spinyaw")

onready var spinmult = find_node("spinmult")
onready var spinbase = find_node("spinbase")
onready var spinbcol = find_node("spinbcol")
onready var spinbsize = find_node("spinbsize")
onready var spinstart = find_node("spinstart")

func _ready():
	pass # Replace with function body.

func _on_doitbutton_pressed():
	
	var mult = float(spinmult.get_line_edit().text)
	var base = spinbase.get_line_edit().text
	var bcol = spinbcol.get_line_edit().text
	var bsize = spinbsize.get_line_edit().text
	var start = int(spinstart.get_line_edit().text) -1 #-1 cause obj stuff starts at 1 instead of 0
	
	var roll = float(spinroll.get_line_edit().text)
	var pitch = float(spinpitch.get_line_edit().text)
	var yaw = float(spinyaw.get_line_edit().text)
	
	if inputOBJ.obj == null:
		return
	
	outputaddballz.text = ""
	outputlinez.text = ""
	
	for l in inputOBJ.obj:
		if l.begins_with("v "):
			var bxyz = l.split(" ")
			var coords = Vector3(int(float(bxyz[1])*mult),-int(float(bxyz[2])*mult),-int(float(bxyz[3])*mult))
			coords = rotate_vec3(coords,roll,pitch,yaw)
			coords = Vector3(round(coords.x),round(coords.y),round(coords.z))
			
			outputaddballz.text += str(base,", ", coords.x,", ", coords.y,", ", coords.z,", ",bcol,", 0, 0, 0, -1, -1, ",bsize,", 0, 0, -1") + "\n"
			#str(base,", ",vec.x,", ",vec.y,", ",vec.z,", ",bcolor,", 0, 0, 0, -1, -1, ",bsize,", 0, 0, -1") + "\n"
		elif l.begins_with("l "):
			var lends = l.split(" ")
			outputlinez.text += str(int(lends[1])+start, ", ", int(lends[2])+start, ", 0, -1, -1, -1, 100, 100") + "\n"
	
#	var linez = ""
#	var ball1
#	var ball2
#	linez += str(ball1, ", ", ball2, ", 0, -1, -1, -1, 100, 100")
#
#	outputlinez.text = linez
