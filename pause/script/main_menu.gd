class_name MainMenu extends Control

@onready var _main_menu_pivot: Control = %MainMenuPivot
@onready var _options_menu_pivot: Control = %OptionsMenuPivot

@onready var _button_play: Button = %ButtonPlay
@onready var _button_options: Button = %ButtonOptions
@onready var _button_quit: Button = %ButtonQuit
@onready var _sensitivity_slider: HSlider = %SensitivitySlider
@onready var _check_button: CheckButton = %CheckButton
@onready var _volume_slider: HSlider = %VolumeSlider
@onready var _apply_settings_button: Button = %ApplySettingsButton
@onready var _exit_settings_button: Button = %ExitSettingsButton

var _tween_options : Tween = null

var is_options_showing := false

func _ready() -> void:
	_connect_button_signals()



func _connect_button_signals() -> void:
	_button_play.pressed.connect(
		func() -> void:
			get_tree().change_scene_to_file("res://levels/level_test.level.tscn")
	)
	_button_options.pressed.connect(animate_options_menu)
	_button_quit.pressed.connect(get_tree().quit)
	
	_exit_settings_button.pressed.connect(animate_options_menu)


func animate_options_menu() -> void:
	if _tween_options != null:
		_tween_options.kill()
	
	_tween_options = create_tween()
	var target_position_x : float = (1679.0 if is_options_showing else 556.0)
	
	_tween_options.tween_property(_options_menu_pivot, "position:x", target_position_x, 0.5)
	is_options_showing = not is_options_showing
