extends Interactible3D
class_name Test_Key

# I can't figure out signals :(
#signal picked_up(argument_1: String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact():
	KeyRing.key_ring["Green"] = true
	print(KeyRing.key_ring)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
