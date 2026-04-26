class_name PlayerController extends CharacterBody3D

## Signal that gets emitted from the walk_towards function
signal walked_to
## Siignal that gets emitted from the turn_camera_towards function
signal looked_at

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _pivot_start_position : float = _camera_pivot.position.y
@onready var _camera: Camera3D = %Camera
@onready var camera: Camera3D = %Camera
@onready var _collision_shape: CollisionShape3D = %CollisionShape3D
@onready var _collsion_shape_start_height : float = _collision_shape.shape.height
@onready var _crouch_ceiling_cast: ShapeCast3D = %CrouchCeilingCast


@export_range(0.001, 5.0) var look_sensitivty := 0.005


@export_category("Ground Movement")
@export_range(1.0, 10.0, 0.1) var max_speed_jog := 4.0
@export_range(1.0, 15.0, 0.1) var max_speed_sprint := 7.0
@export_range(1.0, 10.0, 0.1) var max_speed_crouch := 2.0
@export_range(1.0, 100.0, 0.1) var acceleration_jog := 15.0
@export_range(1.0, 100.0, 0.1) var acceleration_sprint := 25.0
@export_range(1.0, 100.0, 0.1) var deceleration := 12.0

@export_category("Air Movement")
@export_range(1.0, 50.0, 0.1) var gravity := 17.0
@export_range(1.0, 50.0, 0.1) var max_fall_speed := 20.0
@export_range(1.0, 20.0, 0.1) var jump_velocity := 8.0


var is_crouching : bool = false:
	set = set_is_crouching

#region Virtual Functions
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	var is_mouse_button := event is InputEventMouseButton
	var is_mouse_captured := Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	var is_escape_pressed := event.is_action_pressed("ui_cancel")
	
	if is_mouse_button and not is_mouse_captured:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif is_escape_pressed and is_mouse_captured:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if (event is InputEventMouseMotion and is_mouse_captured):
		var look_offset_2d : Vector2 = event.screen_relative * look_sensitivty 
		_rotate_camera_by(look_offset_2d)


func _process(delta: float) -> void:
	var joystick_look_input := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	var look_offset_2d := joystick_look_input * look_sensitivty * delta
	if joystick_look_input.length() > 0.5:
		_rotate_camera_by(look_offset_2d)


func _physics_process(delta: float) -> void:
	var input_direction_2d := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement_direction_2d := input_direction_2d.rotated(-1.0 * _camera.global_rotation.y)
	var movement_direction_3d := Vector3(movement_direction_2d.x, 0.0, movement_direction_2d.y)
	
	## Checks if the player made an intentional movement and sets the player's speed
	var player_wants_to_move := movement_direction_2d.length() > 0.1
	if player_wants_to_move:
		var max_speed := max_speed_jog
		var acceleration := acceleration_jog
		if Input.is_action_pressed("sprint"):
			max_speed = max_speed_sprint
			acceleration = acceleration_sprint
		if is_crouching:
			max_speed = max_speed_crouch
		
		var velocity_ground_plane := Vector3(velocity.x, 0.0, velocity.z)
		var velocity_change := acceleration * delta
		velocity_ground_plane = velocity_ground_plane.move_toward(
			movement_direction_3d * max_speed, velocity_change
		)
		velocity.x = velocity_ground_plane.x
		velocity.z = velocity_ground_plane.z
	else:
		var velocity_ground_plane := Vector3(velocity.x, 0.0, velocity.z)
		velocity_ground_plane = velocity_ground_plane.move_toward(Vector3.ZERO, deceleration * delta)
		velocity.x = velocity_ground_plane.x
		velocity.z = velocity_ground_plane.z
	
	
	## If the player is on the floor, set the player crouching if the button is pressed
	if is_on_floor():
		set_is_crouching(Input.is_action_pressed("crouch"))
	
	## Adds gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
		velocity.y = maxf(velocity.y, -max_fall_speed)
	
	## Handles player jump
	if is_on_floor() and Input.is_action_just_pressed("jump") and not is_crouching:
		velocity.y = jump_velocity
	
	## Stores the last state of the player when they left the ground
	var  was_in_air := not is_on_floor() 
	## Gets the falling speed from the absolut value of the player's current y velocity
	var fall_speed := absf(velocity.y)
	
	move_and_slide()
	
	## Checks if the Player left the ground in the last frame and is on the floor now
	var just_landed := was_in_air and is_on_floor()
	
	## If the player just landed, play the impact animation
	if just_landed:
		play_landing_animation(fall_speed)
#endregion

#region Camera Controls
func _rotate_camera_by(look_offset_2d: Vector2) -> void:
	_camera.rotation.y -= look_offset_2d.x
	_camera.rotation.x -= look_offset_2d.y
	_camera.rotation.y = wrapf(_camera.rotation.y, -PI, PI)
	
	const MAX_VERTICAL_ANGLE := PI / 3.0
	_camera.rotation.x = clampf(_camera.rotation.x, -1.0 * MAX_VERTICAL_ANGLE, MAX_VERTICAL_ANGLE)
	
	_camera.orthonormalize()
#endregion

#region Animation Functions
## Function animates the Camera's Pivot node up and down based on how fast the Player is falling
func play_landing_animation(fall_speed: float) -> void:
	var impact_intensity := fall_speed / max_fall_speed
	
	var impact_tween := create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	impact_tween.tween_property(_camera_pivot, "position:y", _camera_pivot.position.y - 0.2 * impact_intensity, 0.06)
	impact_tween.tween_property(_camera_pivot, "position:y", _pivot_start_position, 0.1)

## Function rotates the Player's Camera node to a target position over a duration
func turn_camera_towards(target_global_position: Vector3, turn_duration: float) -> void:
	var angle_to_target : float = global_position.angle_to(target_global_position)
	
	var tween := create_tween().set_parallel()
	
	tween.tween_property(_camera, "rotation:x", angle_to_target, turn_duration)
	tween.tween_property(_camera, "rotation:y", angle_to_target, turn_duration)
	
	tween.finished.connect(
		func() -> void:
			looked_at.emit()
	)

## Function animates the Player's global_position to a target position of type over a duration
func walk_towards(target_global_position: Vector3, duration: float) -> void:
	var tween := create_tween()
	tween.tween_property(self, "global_position", target_global_position, duration)
	tween.finished.connect(
		func() -> void:
			walked_to.emit()
	)
#endregion

#region Setter Functions
func set_is_crouching(new_value: bool) -> void:
	if is_crouching == new_value:
		return
	
	if new_value == false:
		_crouch_ceiling_cast.force_shapecast_update()
		if _crouch_ceiling_cast.is_colliding():
			return
	
	is_crouching = new_value
	
	if is_crouching:
		_collision_shape.shape.height = _collsion_shape_start_height / 2.0
	else:
		_collision_shape.shape.height = _collsion_shape_start_height
	
	_collision_shape.position.y = _collision_shape.shape.height / 2.0
	
	var target_pivot_height := 0.0
	
	if is_crouching:
		target_pivot_height = _pivot_start_position * 0.7
	else:
		target_pivot_height = _pivot_start_position
		
	var pivot_tween := create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	pivot_tween.tween_property(_camera_pivot, "position:y", target_pivot_height, 0.25)
#endregion
