class_name FlashlightController extends Node3D

@onready var _spot_light: SpotLight3D = %SpotLight3D
@onready var _light_toggle_timer: Timer = %LightToggleTimer

@export var projector_texture : Texture2D = null:
	set = set_projector_texture

@export var battery := 300.0
## Current toggle state of the light as a boolean
var _is_on := true:
	set = set_in_on


func _ready() -> void:
	_is_on = true


func _process(delta: float) -> void:
	battery -= delta
	
	if battery <= 0.0:
		_is_on = false


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
	if battery <= 0.0:
		new_value = false
	_is_on = new_value
	_spot_light.visible = _is_on
