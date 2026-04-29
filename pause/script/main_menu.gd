class_name MainMenu extends Control

@onready var _button_play: TextureButton = $Main/PlayButton
@onready var _button_options: TextureButton = $Main/OptionsButton
@onready var _button_quit: TextureButton = $Main/ExitButton
@onready var _options_menu_pivot: Control = $Options
@onready var pauseButton_texture_rect: TextureRect = $Main/PlayButton/TextureRect
@onready var optionsButton_texture_rect: TextureRect = $Main/OptionsButton/TextureRect
@onready var exitButton_texture_rect: TextureRect = $Main/ExitButton/TextureRect

var _tween_options : Tween = null

var is_options_showing := false

func _ready() -> void:
	_connect_button_signals()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _playbuttonMouseOn()->void:
	pauseButton_texture_rect.self_modulate = Color(1,1,1,1)

func _playbuttonMouseOff()->void:
	pauseButton_texture_rect.self_modulate = Color(1,1,1,0)

func _optionsbuttonMouseOn()->void:
	optionsButton_texture_rect.self_modulate = Color(1,1,1,1)

func _optionsbuttonMouseOff()->void:
	optionsButton_texture_rect.self_modulate = Color(1,1,1,0)

func _exitbuttonMouseOn()->void:
	exitButton_texture_rect.self_modulate = Color(1,1,1,1)

func _exitbuttonMouseOff()->void:
	exitButton_texture_rect.self_modulate = Color(1,1,1,0)

func _connect_button_signals() -> void:
	_button_play.pressed.connect(
		func() -> void:
			get_tree().change_scene_to_file("res://levels/map_test_000_001.tscn")
	)
	_button_play.mouse_entered.connect(_playbuttonMouseOn)
	_button_play.mouse_exited.connect(_playbuttonMouseOff)
	_button_options.mouse_entered.connect(_optionsbuttonMouseOn)
	_button_options.mouse_exited.connect(_optionsbuttonMouseOff)
	_button_quit.mouse_entered.connect(_exitbuttonMouseOn)
	_button_quit.mouse_exited.connect(_exitbuttonMouseOff)
	_button_options.pressed.connect(animate_options_menu)
	_button_quit.pressed.connect(get_tree().quit)


func animate_options_menu() -> void:
	if _tween_options != null:
		_tween_options.kill()
	
	_tween_options = create_tween()
	var _x : float = DisplayServer.screen_get_size().x
	var target_position_x : float = (_x if is_options_showing else 0.0)
	
	_tween_options.tween_property(_options_menu_pivot, "position:x", target_position_x, 0.5)
	is_options_showing = not is_options_showing
