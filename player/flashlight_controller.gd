class_name FlashlightController extends Node3D

@onready var _spot_light: SpotLight3D = %SpotLight3D
@onready var _light_toggle_timer: Timer = %LightToggleTimer

@export var projector_texture : Texture2D = null:
	set = set_projector_texture

## Chance the light has to deactivate expressed as a percentage
@export var light_deactivation_chance := 0.9
## Current toggle state of the light as a boolean
var _is_on := true:
	set = set_in_on

func _ready() -> void:
	_is_on = true
	
	_light_toggle_timer.timeout.connect(
		func() -> void:
			if _is_on:
				calculate_light_state()
	)

## Toggle the light's visible property when the player presses the "flashlight" input
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		set_in_on(not _is_on)


## Function set the light_projector property of the _spot_light at runtime
func set_projector_texture(new_texture: Texture2D) -> void:
	projector_texture = new_texture
	
	if _spot_light == null:
		return
	
	_spot_light.light_projector = projector_texture

## Function sets the state of the _is_on variable and the _spot_light's visible property
func set_in_on(new_value: bool) -> void:
	_is_on = new_value
	_spot_light.visible = _is_on


func calculate_light_state()-> void:
	var chance : float = randf()
	print(chance)
	
	if chance < light_deactivation_chance:
		set_in_on(false)
