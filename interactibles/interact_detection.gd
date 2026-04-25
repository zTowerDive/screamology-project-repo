extends RayCast3D

# Collision Mask is Layer 3: Interactable objects should be on Collision Layer 3
#	Will only collide with AREAS because Interactible3D extends Area3D
#	Idk if this actually matters but it seems like good practice?

# Raycast Z-axis can be adjusted to change character's 'reach'. 

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		$InteractChecker.text = collider.prompt
		if Input.is_action_just_pressed("interact"):
			collider.interact()
	else:
		$InteractChecker.text = ''
