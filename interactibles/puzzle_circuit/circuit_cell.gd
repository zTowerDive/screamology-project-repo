extends Interactable3D
class_name CIRCUIT_CELL


var is_powered := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func interact():
	super()
	rotate_z(PI/2)
