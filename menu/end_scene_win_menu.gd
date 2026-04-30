extends Control

@onready var play_button: TextureButton = $Main/PlayButton
@onready var exit_button: TextureButton = $Main/ExitButton
@onready var exit_button_texture_rect: TextureRect = $Main/ExitButton/TextureRect
@onready var play_button_texture_rect: TextureRect = $Main/PlayButton/TextureRect

func _ready() -> void:
	_connect_button_signals()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _connect_button_signals() -> void:
	play_button.pressed.connect(
		func() -> void:
			get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	)
	exit_button.pressed.connect(get_tree().quit)
	play_button.mouse_entered.connect(_playbuttonMouseOn)
	play_button.mouse_exited.connect(_playbuttonMouseOff)
	exit_button.mouse_entered.connect(_exitbuttonMouseOn)
	exit_button.mouse_exited.connect(_exitbuttonMouseOff)

func _exitbuttonMouseOn()->void:
	exit_button_texture_rect.self_modulate = Color(1,1,1,1)

func _exitbuttonMouseOff()->void:
	exit_button_texture_rect.self_modulate = Color(1,1,1,0)

func _playbuttonMouseOn()->void:
	play_button_texture_rect.self_modulate = Color(1,1,1,1)

func _playbuttonMouseOff()->void:
	play_button_texture_rect.self_modulate = Color(1,1,1,0)
