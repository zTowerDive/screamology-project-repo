class_name CreatureController extends CharacterBody3D

@onready var _vision_area: VisionArea3D = %VisionArea3D
@onready var _mesh: Node3D = $Sketchfab_Scene
@onready var _wander_timer: Timer = %WanderTimer

@export var chase_speed := 6.0
@export var wander_speed := 3.0

enum State {
	StateLookAtPlayer,
	StateWander,
	StateChase,
	StateIdle,
}

var current_state : State = State.StateWander:
	set = set_current_state

var tween_rat : Tween = null

#region Virtual Functions
func _ready() -> void:
	_wander_timer.timeout.connect(set_current_state.bind(State.StateWander))
	_wander_timer.start()


func _physics_process(delta: float) -> void:
	
	match current_state:
		State.StateIdle:
			process_idle_state(delta)
		State.StateChase:
			process_chase_state(delta)
		State.StateWander:
			process_wander_state(delta)
		State.StateLookAtPlayer:
			process_look_at_player_state(delta)
	
	## Apply Gravity
	if not is_on_floor():
		velocity.y -= 17.0 * delta
	
	move_and_slide()
#endregion


#region Setter Functions
func set_current_state(new_state: State) -> void:
	if current_state == new_state:
		return
	
	var previous_state = current_state
	
	current_state = new_state
	
	## Runs exit code based on last State
	match previous_state:
		State.StateIdle:
			print("Now exiting State: ", State.StateIdle)
		
		State.StateChase:
			print("Now exiting State: ", State.StateChase)
		
		State.StateWander:
			print("Now exiting State: ", State.StateWander)
			if tween_rat != null:
				tween_rat.kill()
		
		State.StateLookAtPlayer:
			print("Now exiting State: ", State.StateLookAtPlayer)
	
	## Runs entering code based on new State
	match current_state:
		State.StateIdle:
			print("Now entering State: ", State.StateIdle)
		
		State.StateChase:
			print("Now entering State: ", State.StateChase)
		
		State.StateWander:
			print("Now entering State: ", State.StateWander)
			var random_location := get_random_location(5.0, 15.0)
			
			walk_to_point(Vector3(random_location.x, 0.0, random_location.z), wander_speed)
		
		State.StateLookAtPlayer:
			print("Now entering State: ", State.StateLookAtPlayer)
			
			velocity = Vector3.ZERO

#endregion


#region State Processing Functions
func process_idle_state(delta: float) -> void:
	pass

func process_chase_state(delta: float) -> void:
	var target_position := _vision_area.focused_body.global_position
	var direction := self.global_position.direction_to(target_position)
	
	velocity = direction * chase_speed * delta

func process_wander_state(delta: float) -> void:
	
	if _vision_area.player_detected.get_connections().is_empty():
		_vision_area.player_detected.connect(set_current_state.bind(State.StateLookAtPlayer))

func process_look_at_player_state(delta) -> void:
	var target_position := _vision_area.focused_body.global_position
	look_at(target_position, Vector3.UP, true)
	
	if _vision_area.player_lost.get_connections().is_empty():
		_vision_area.player_lost.connect(set_current_state.bind(State.StateWander))
#endregion


func walk_to_point(target_location: Vector3, target_speed: float) -> void:
	look_at(target_location, Vector3.UP, true)
	var direction_to_target := global_position.direction_to(target_location)
	
	velocity = direction_to_target * target_speed


func get_random_location(min_range: float, max_range: float) -> Vector3:
	var random_angle := randf_range(0.0, 2.0 * PI)
	var random_direction := Vector3.RIGHT.rotated(Vector3.UP, random_angle)
	var random_distance := randf_range(min_range, max_range)
	
	return random_direction * random_distance
