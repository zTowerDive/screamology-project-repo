class_name TESTDoorLocked
extends Interactible3D

@onready var _static_body_collision_shape: CollisionShape3D = %StaticBodyCollisionShape3D
@onready var _door_mesh: MeshInstance3D = $MeshInstance3D

var _tween_door : Tween = null

var is_active := false:
	set = set_is_active

func interact() -> void:
	if KeyRing.key_ring["Green"] == false:
		prompt = "You need the Green key to open"
	else:
		set_is_active(not is_active)
		prompt = "Open Door"
func set_is_active(new_value: bool) -> void:
	is_active = new_value
	_static_body_collision_shape.disabled = is_active
	
	
	var top_value := 2.45 if is_active else 0.5
	
	if _tween_door != null:
		_tween_door.kill()
	
	_tween_door = create_tween().set_ease(Tween.EASE_OUT)
	_tween_door.set_trans(Tween.TRANS_BACK if is_active else Tween.TRANS_BOUNCE)
	
	_tween_door.tween_property(_door_mesh, "position:y", top_value, 1.0)
