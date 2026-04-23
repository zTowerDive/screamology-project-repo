class_name PlayerController extends CharacterBody3D


@onready var _camera: Camera3D = %Camera


@export_range(0.001, 5.0) var look_sensitivty := 2.5


@export_category("Ground Movement")
@export_range(1.0, 10.0, 0.1) var max_speed_jog := 4.0
@export_range(1.0, 15.0, 0.1) var max_speed_sprint := 7.0
@export_range(1.0, 100.0, 0.1) var acceleration_jog := 15.0
@export_range(1.0, 100.0, 0.1) var acceleration_sprint := 25.0
@export_range(1.0, 100.0, 0.1) var deceleration := 12.0



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
	
	var player_wants_to_move := movement_direction_2d.length() > 0.1
	if player_wants_to_move:
		var max_speed := max_speed_jog
		var acceleration := acceleration_jog
		if Input.is_action_pressed("sprint"):
			max_speed = max_speed_sprint
			acceleration = acceleration_sprint
		
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
	
	
	move_and_slide()


func _rotate_camera_by(look_offset_2d: Vector2) -> void:
	_camera.rotation.y -= look_offset_2d.x
	_camera.rotation.x -= look_offset_2d.y
	_camera.rotation.y = wrapf(_camera.rotation.y, -PI, PI)
	
	const MAX_VERTICAL_ANGLE := PI / 3.0
	_camera.rotation.x = clampf(_camera.rotation.x, -1.0 * MAX_VERTICAL_ANGLE, MAX_VERTICAL_ANGLE)
	
	_camera.orthonormalize()
