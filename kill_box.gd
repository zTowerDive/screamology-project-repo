class_name KillBox3D extends Area3D

func _ready() -> void:
	body_entered.connect(
		func(body: Node3D) -> void:
			if body is PlayerController:
				get_tree().change_scene_to_file("res://menu/endScene_lose_menu.tscn")
	)
