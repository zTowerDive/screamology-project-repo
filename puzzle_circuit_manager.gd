extends Interactable3D
class_name CELL_SOURCE

@export var connector_1: CONNECTORS_SOURCE = null
@export var connector_2: CONNECTORS_SOURCE = null
@export var connector_3: CONNECTORS_SOURCE = null

var cell_connectors := [connector_1, connector_2, connector_3]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#interacted_with.connect(await update())
	
# This is called everytime a cell is turned.
func update():
	pass
	#for i in cell_connectors:
		#var connection = i.get_overlapping_areas()
		#if connection != null:
			#print(str(i) + " is being pulsed.")
			##await i.pulse()
		#else:
			#print(str(i) + " has no connections.")

func _on_interacted_with():
	pass
