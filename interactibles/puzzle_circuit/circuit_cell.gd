extends Interactable3D
class_name CIRCUIT_CELL

# Bool for if cell has power or not
var is_powered := false

# Assign connection points, used for logic
@export var connection_1 : CIRCUIT_CONNECTION_POINT = null
@export var connection_2 : CIRCUIT_CONNECTION_POINT = null
@export var connection_3 : CIRCUIT_CONNECTION_POINT = null

# Creates an array that stores each connection point
var connection_points: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connection_points = [connection_1, connection_2, connection_3]

func update():
	print("Updating...")
	var recievers = update_recievers()
	print("Checking recievers...")
	match recievers:
		0:
			pass
		1:
			power_cell()
		_ when recievers >= 2:
			overload()
	
func update_recievers():
	var counter = 0
	for i in connection_points:
		print("Checking connection #" + str(i) + "...")
		if i != null:
			var check = i.check_recieving()
			if check == true:
				counter += 1;
	return counter

func emit_power_to_connections(reciever):
	for i in connection_points:
		if i != reciever:
			i.emit_power()

func interact():
	super()
	is_powered = false
	rotate_z(PI/2)
	update()

func power_cell():
	is_powered = true
	
func overload():
	pass
