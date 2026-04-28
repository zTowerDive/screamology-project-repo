extends TextureButton
@onready var arrow: TextureRect = $Arrow
@onready var pause: Control = $"../../Pause"
@onready var options: Control = $".."
@onready var background: TextureRect = $"../../background"
@export var sprite_paused : Texture2D


func endAnimation()->void:
	var tween = get_tree().create_tween()
	tween.tween_property(background, "rotation", 0.0, 0.3)


func _on_mouse_entered() -> void:
	arrow.self_modulate = Color(1.61, 1.61, 1.61, 1.0)
	var tween = get_tree().create_tween()
	tween.tween_property(arrow, "scale", Vector2(0.8,0.8), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(arrow, "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_BOUNCE)


func _on_mouse_exited() -> void:
	arrow.self_modulate = Color(1.61, 1.61, 1.61, 0.0)


func _on_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(background, "rotation", -0.05, 0.15)
	tween.tween_property(background, "rotation", 0.05, 0.3)
	tween.tween_callback(func():
		pause.show()
		pause.endAnimation()
		background.texture = sprite_paused
		options.hide()
		)
