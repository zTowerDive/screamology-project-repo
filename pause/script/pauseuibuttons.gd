extends Control
@onready var texture_rect_resume: TextureRect = $Paper/ResumeButton/TextureRect
@onready var texture_rect_options: TextureRect = $Paper/OptionsButton/TextureRect
@onready var texture_rect_quit: TextureRect = $Paper/QuitButton/TextureRect
@onready var pause: Control = $"."
@onready var options: Control = $"../Options"
@onready var background: TextureRect = $"../background"
@export var sprite_options : Texture2D
@onready var back_button: TextureButton = $"../Options/BackButton"
@export var paused:bool=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(get_tree().get_current_scene().get_name()!="pause_menu"):
		#if Input.is_action_just_pressed("pause"):
			#_pauseMenu()
		pass

func _pauseMenu()->void:
	if(paused):
		get_tree().paused = false
		hide()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		get_tree().paused = true
		show()
		visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	paused=!paused

func _on_resume_button_mouse_exited() -> void:
	texture_rect_resume.self_modulate = Color(1,1,1,0)


func _on_resume_button_mouse_entered() -> void:
	texture_rect_resume.self_modulate = Color(1,1,1,1)


func _on_resume_button_pressed() -> void:
	_pauseMenu()


func _on_options_button_mouse_entered() -> void:
	texture_rect_options.self_modulate = Color(1,1,1,1)


func _on_options_button_mouse_exited() -> void:
	texture_rect_options.self_modulate = Color(1,1,1,0)


func _on_options_button_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(background, "rotation", 0.05, 0.15)
	tween.tween_property(background, "rotation", -0.05, 0.3)
	tween.tween_callback(func():
		options.show()
		back_button.endAnimation()
		background.texture = sprite_options
		pause.hide()
		)

func endAnimation()->void:
	var tween = get_tree().create_tween()
	tween.tween_property(background, "rotation", 0.0, 0.3)


func _on_quit_button_mouse_entered() -> void:
	texture_rect_quit.self_modulate = Color(1,1,1,1)


func _on_quit_button_mouse_exited() -> void:
	texture_rect_quit.self_modulate = Color(1,1,1,0)

func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
