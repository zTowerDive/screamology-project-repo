class_name PlayerHUD extends Control



@onready var _current_task_label: RichTextLabel = %CurrentTaskLabel
@onready var _dialogue_label: RichTextLabel = %DialogueLabel

var _tween_text : Tween = null

func _ready() -> void:
	show_text(_current_task_label, preload("uid://m1y8gtebwv1r"), 3.0)


func show_text(text_label: RichTextLabel, dialogue_item: DialogueItem, duration: float) -> void:
	if _tween_text != null:
		_tween_text.kill()
	
	if text_label == null:
		return
	
	_tween_text = create_tween()
	text_label.text = dialogue_item.text
	text_label.visible_ratio = 0.0
	
	_tween_text.tween_property(text_label, "visible_ratio", 1.0, duration)
