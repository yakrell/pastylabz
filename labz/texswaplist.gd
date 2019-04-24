extends Control

onready var editTexList = get_node("hsc/vbc/editTexList")
onready var editTexSlots = get_node("hsc/vbc/editTexSlots")

onready var spinMaximum = get_node("hsc/vbc/spinMaximum")
onready var spinStart = get_node("hsc/vbc/spinStart")

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
	var permuMax = int(spinMaximum.get_line_edit().text)
	var permuCurrent = int(spinStart.get_line_edit().text)
	
	var slotArrayPermutations = get_slotarray_permutations(slotArray)
	
	for permutation in slotArrayPermutations:
		
		var permuString = str("#",permuCurrent,"\n")
		for slot in permutation:
			# -1 to match the line numbers on the textedit :c
			var texIdx = clamp(int(slot)-1,0,64)
			var tex = texArray[texIdx] if texArray.size() > texIdx else ";MISSING TEXTURE: NOT FOR RIN KIN"
			permuString = permuString + str(tex, "\n")
		
		#append the string backwards
		outputString = permuString + outputString
		permuCurrent +=1
		if permuCurrent > permuMax:
			break
	
	
	editOutput.text = outputString

#slotarray stuff by github.com/mel-taylor
func get_slotarray_permutations(slotArray):
	var inputArray = []
	#turn each element in first slotarray into its own array
	for i in range (slotArray[0].size()):
		inputArray.append([slotArray[0][i]])
	#for number of slotarrays, generate new set of permutations
	for i in range(slotArray.size() - 1):
		inputArray = get_slot_permutations(inputArray, slotArray[i + 1])
	#print("output array is: ", inputArray)
	return inputArray

func get_slot_permutations(prevArray, currentArray):
	var outputArrays = []
	#print("current prevArray is ", prevArray)
	#print("current currentArray is ", currentArray)
	for i in prevArray.size():
		for j in currentArray.size():
			var newArray = prevArray[i].duplicate()
			newArray.append(currentArray[j])
			#print("current newArray is: ", newArray)
			outputArrays.append(newArray.duplicate())
	#print("current output array is ", outputArrays)
	return outputArrays
