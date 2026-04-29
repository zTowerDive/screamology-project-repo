class_name PauseMenu extends Control

@onready var _resume_button: TextureButton = $Pause/Paper/ResumeButton

@onready var _options: Control = %Options


var is_paused := false

func _ready() -> void:
	visible = false
	_connect_signals()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not is_paused:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			_pause()
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			_unpause()


func _pause() -> void:
	is_paused = true
	visible = true
	get_tree().paused = true


func _unpause() -> void:
	is_paused = false
	visible = false
	get_tree().paused = false


func _show_options() -> void:
	_options.visible = true


func _hide_options() -> void:
	_options.visible = false


func _connect_signals() -> void:
	_resume_button.pressed.connect(_unpause)
