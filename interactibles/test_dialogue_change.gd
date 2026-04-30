class_name DialogueChange extends Interactable3D

@export var dialogue_item : DialogueItem

func interact() -> void:
	super()
	
	var player_hud : PlayerHUD = get_tree().root.get_node("/root/Node3D/Player/PlayerHUD")
	player_hud.show_dialogue_text(dialogue_item, 3.0)
