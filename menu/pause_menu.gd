class_name PauseMenu extends Control


@onready var _resume_button: TextureButton = %ResumeButton
@onready var _options_button: TextureButton = %OptionsButton
@onready var _quit_button: TextureButton = %QuitButton
@onready var _back_button: TextureButton = %BackButton

@onready var _sensitivity_slider: HSlider = %SensitivitySlider
@onready var _fullscreen_button: CheckButton = %CheckButton
@onready var _volume_slider: HSlider = %VolumeSlider

@onready var _options: TextureRect = %Options


var is_paused := false

func _ready() -> void:
	visible = false
	_connect_signals()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		if not is_paused:
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


func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)


func _connect_signals() -> void:
	_resume_button.pressed.connect(_unpause)
	_options_button.pressed.connect(_show_options)
	_quit_button.pressed.connect(get_tree().quit)
	_back_button.pressed.connect(_hide_options)
	
	_volume_slider.value_changed.connect(_on_value_changed)
