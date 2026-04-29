extends Area3D
class_name CIRCUIT_CONNECTION_POINT

# This assigns the cell the connection point belongs to
@export var cell: CIRCUIT_CELL = null

# Logic variables
var is_emitting_power := false
var is_recieving_power := false

# Signal 
signal short_circuit

func check_recieving():
	var connection = get_overlapping_areas()
	print(connection)
	if connection.is_empty():
		print("No connections.")
		return false
	else:
		if connection[0].is_emitting_power == true:
			is_recieving_power = true
			print("Recieving Power!")
			return true
		else:
			return false

func emit_power():
	var connection = get_overlapping_areas()
	if connection.is_emitting_power == true:
		short_circuit.emit()
		pass
	else:
		connection.check_recieving()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
