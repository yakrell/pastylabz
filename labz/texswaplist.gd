extends Control

onready var editTexList = get_node("hsc/vbc/editTexList")
onready var editTexSlots = get_node("hsc/vbc/editTexSlots")

onready var spinMaximum = get_node("hsc/vbc/spinMaximum")

onready var editOutput = get_node("hsc/editOutput")

func _ready():
	#print(get_node("hsc/vbc/TextEdit").get_line(1-1))
	#Remember To Take One From The Input Line Numbers To Get The Index!!!!!!!!
	pass

func _on_butCreateList_pressed():
	var texArray = []
	for lnum in editTexList.get_line_count():
		texArray.append(editTexList.get_line(lnum))
	
	
	var slotArray = []
	for lnum in editTexSlots.get_line_count():
		slotArray.append(editTexSlots.get_line(lnum).split(","))
	#print(slotArray)
	
	var outputString = "##"
#
#	var permuMax = int(spinMaximum.get_line_edit().text)
#	var permuCurrent = 1
#
#	for texIdx in slotArray[0]:
#		#append the string backwards
#		if texArray.size() >= int(texIdx):
#			outputString = print_permutation(permuCurrent, texArray, texIdx, slotArray.size()) + outputString
#			permuCurrent+=1
	
	### PLAN PROPERLY ###
	# find all permutations of each slot, put them in their own arrays nested in a big one
	var slotArrayPermutations = []
	for slot in slotArray.size():
		slotArrayPermutations.append( get_slot_permutations(slotArray, slot, texArray) )
	print(slotArrayPermutations)
	
	#do a while loop until the end of the last slots permutations or hitting the max permutation limit
	
	editOutput.text = outputString


func get_slot_permutations(slotArray, slot, texArray):
	var slot_permutation_array = slotArray.duplicate()[slot]
	for i in slot_permutation_array.size():
		if texArray.size() >= int(slot_permutation_array[i]) && int(slot_permutation_array[i]) > 0:
			slot_permutation_array[i] = texArray[int(slot_permutation_array[i])-1]
		else:
			slot_permutation_array[i] = ";NOT FOR RIN KIN (invalid texture number)"
	return slot_permutation_array



#func print_permutation(permuCurrent, texArray, texIdx, slotsNum):
#	#build a permutation by putting together the slots
#	var permutation_string = str("#",permuCurrent,"\n")
#	for i in slotsNum:
#		permutation_string += print_slot(permuCurrent, texArray, texIdx)
#	return permutation_string

#func print_slot(permuCurrent, texArray, texIdx):
#	#take away one to convert from line number to index
#	return texArray[int(texIdx)-1] + "\n"
