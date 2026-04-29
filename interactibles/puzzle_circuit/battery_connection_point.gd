extends Area3D
class_name BATTERY_CONNECTION_POINT

# This assigns the cell the connection point belongs to
@export var cell: CIRCUIT_CELL = null

# Signals
signal emit_power

# Logic variables
var is_emitting_power := true

func check_connection():
	var connection = get_overlapping_areas()
	connection.is_emitting_power = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
