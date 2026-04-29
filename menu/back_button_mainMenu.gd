extends TextureButton
@onready var main_menu: MainMenu = $"../../.."

@onready var arrow: TextureRect = $Arrow

func _on_mouse_entered() -> void:
	arrow.self_modulate = Color(1.61, 1.61, 1.61, 1.0)
	var tween = get_tree().create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(arrow, "scale", Vector2(0.8,0.8), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(arrow, "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_BOUNCE)


func _on_mouse_exited() -> void:
	arrow.self_modulate = Color(1.61, 1.61, 1.61, 0.0)


func _on_pressed() -> void:
	main_menu.animate_options_menu()
