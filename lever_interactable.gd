extends Interactable3D
class_name LEVER_INTERACTABLE

@onready var wrong: AudioStreamPlayer3D = $"../../../WRONG"
@onready var correct: AudioStreamPlayer3D = $"../../../CORRECT"


var code_lock := ["Seahorse", "Mare", "Horse", "Jiraff"]
var code_input := []
# Button Hook-Ups
#--------------------------------------------------
# Assign buttons for input
@export var button_1: Interactable3D = null
@export var button_2: Interactable3D = null
@export var button_3: Interactable3D = null
@export var button_4: Interactable3D = null
@export var button_5: Interactable3D = null
@export var button_6: Interactable3D = null

#Hook-up all the signals
func _ready():
	button_1.button_pressed.connect(button_name)
	button_2.button_pressed.connect(button_name)
	button_3.button_pressed.connect(button_name)
	button_4.button_pressed.connect(button_name)
	button_5.button_pressed.connect(button_name)
	button_6.button_pressed.connect(button_name)

# This is called when a button is pressed. It adds to the input array.
func button_name(input):
	code_input.append(input)
	print(code_input)

func code_check(input_check):
	if input_check == code_lock:
		correct.play()
	else:
		wrong.play()
	code_input.clear()
	
func interact():
	super()
	code_check(code_input)
