extends TextureButton
@onready var textureCheck: TextureRect = $Check
@export var _sprite_check:Array[Texture2D]
@export var _sprite_button:Array[Texture2D]
@export var bChecked:bool=false
@onready var check_button: TextureButton = $"."

func _on_mouse_entered() -> void:
	textureCheck.self_modulate = Color(1.61, 1.61, 1.61, 1.0)
	var tween = get_tree().create_tween()
	tween.tween_property(textureCheck, "scale", Vector2(0.8,0.8), 0.1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(textureCheck, "scale", Vector2(1.5,1.5), 0.5).set_trans(Tween.TRANS_BOUNCE)


func _on_mouse_exited() -> void:
	textureCheck.self_modulate = Color(1.61, 1.61, 1.61, 0.0)


func _on_pressed() -> void:
	bChecked=!bChecked
	var i : int=0
	if bChecked : i=0
	else:i=1
	check_button.texture_normal=_sprite_button[i]
	textureCheck.texture=_sprite_check[i]
