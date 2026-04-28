extends Control
@onready var texture_rect_resume: TextureRect = $Paper/ResumeButton/TextureRect
@onready var texture_rect_options: TextureRect = $Paper/OptionsButton/TextureRect
@onready var texture_rect_quit: TextureRect = $Paper/QuitButton/TextureRect
@onready var pause: Control = $"."
@onready var options: Control = $"../Options"
@onready var pause_menu: Control = $".."
@onready var background: TextureRect = $"../background"
@export var sprite_options : Texture2D
@onready var back_button: TextureButton = $"../Options/BackButton"

func _on_resume_button_mouse_exited() -> void:
	texture_rect_resume.self_modulate = Color(1,1,1,0)


func _on_resume_button_mouse_entered() -> void:
	texture_rect_resume.self_modulate = Color(1,1,1,1)


func _on_resume_button_pressed() -> void:
	pause_menu.hide()


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
	pass
