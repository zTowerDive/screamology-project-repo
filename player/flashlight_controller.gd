class_name FlashlightController extends Node3D

@onready var _spot_light: SpotLight3D = %SpotLight3D
@export var projector_texture : Texture2D = null:
	set = set_projector_texture

var _is_on := true

func _ready() -> void:
	_is_on = true

## Toggle the light's visible property when the player presses the "flashlight" input
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("flashlight"):
		_spot_light.visible = not _is_on
		_is_on = not _is_on


func set_projector_texture(new_texture: Texture2D) -> void:
	projector_texture = new_texture
	
	if _spot_light == null:
		return
	
	_spot_light.light_projector = projector_texture
