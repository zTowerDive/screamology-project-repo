class_name HidingLocker3D extends Interactable3D

@export var is_open := false
var tween_door : Tween = null

@onready var door_pivot_1: Node3D = %door_pivot_1
@onready var door_pivot_2: Node3D = %door_pivot_2
@onready var door_pivot_3: Node3D = %door_pivot_3

@onready var body_collision: CollisionShape3D = %CollisionShape3D
@onready var door_collision_1: CollisionShape3D = $hiding_locker/hiding_locker_low/door_pivot_1/locker_door_1_low/StaticBody3D/CollisionShape3D
@onready var door_collision_2: CollisionShape3D = $hiding_locker/hiding_locker_low/door_pivot_2/locker_door_2_low/StaticBody3D/CollisionShape3D
@onready var door_collision_3: CollisionShape3D = $hiding_locker/hiding_locker_low/door_pivot_3/locker_door_3_low/StaticBody3D/CollisionShape3D

func interact() -> void:
	super()
	animate_door()

func animate_door() -> void:
	if tween_door != null:
		tween_door.kill()
	
	tween_door = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	
	is_open = not is_open
	body_collision.disabled = is_open
	door_collision_1.disabled = is_open
	door_collision_2.disabled = is_open
	door_collision_3.disabled = is_open
	
	var target_rotation := 90 if is_open else 0
	
	tween_door.tween_property(door_pivot_1, "rotation_degrees:z", target_rotation, .33)
	tween_door.tween_property(door_pivot_2, "rotation_degrees:z", target_rotation, .33)
	tween_door.tween_property(door_pivot_3, "rotation_degrees:z", target_rotation, .33)
