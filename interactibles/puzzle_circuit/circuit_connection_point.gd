extends Area3D
class_name CIRCUIT_CONNECTION_POINT


# This assigns the cell the connection point belongs to
@export var cell: CIRCUIT_CELL = null

# Signals
#signal give_power

# Logic variables
var is_giving_power := false
var is_recieving_power := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
