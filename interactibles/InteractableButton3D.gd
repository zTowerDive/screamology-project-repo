extends Interactable3D
class_name InteractableButton3D

# This allows you to name the button and relay it via signal when pressed.
@export var button_name: String = "button"

signal button_pressed(button_name)

func interact():
	super()
	button_pressed.emit(button_name)
