extends Control

var colchart = load("res://palette/ColorChart.png").get_data()

func _ready():
	#parse_chart()
	#save_chart()
	pass

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
	
	return str(colarray)

func save_chart():
	var palimg = Image.new()
	palimg.create( 16, 16, false, Image.FORMAT_RGB8 )
	palimg.lock()
	
	for y in 16:
		for x in 16:
			palimg.set_pixel(x,y, Color(Global.color_chart[x+y*16]) )
	
	palimg.save_png("res://petzpalette.png")
	

func wrap_text_lines(text : String, prepend, append):
	var lines = text.split("\n")
	var new_text = ""
	for ln in lines:
		ln = str(prepend,ln,append)
		new_text += ln + "\n"
	
	return new_text
	


func rotate_vec3(vec : Vector3, roll : float, pitch : float, yaw : float):
	#use this basis for some reason
	var basis = Basis( Vector3(1,0,0), Vector3(0,1,0), Vector3(0,0,1))
	
	
	var rotation = Vector3(deg2rad(pitch),deg2rad(yaw),deg2rad(roll))
	#print( rotation.y)
	# roll > pitch > yaw
	vec = vec.rotated( basis.z, rotation.z )
	vec = vec.rotated( basis.x, rotation.x )
	vec = vec.rotated( basis.y, rotation.y )
	
	return vec
