class_name PlayerHUD extends Control


@onready var tasks_rect: TextureRect = $tasksRect
@onready var _current_task_label: RichTextLabel = %CurrentTaskLabel
@onready var _dialogue_label: RichTextLabel = %DialogueLabel
@onready var dialogue_rect: TextureRect = $dialogueRect

var _tween_text : Tween = null

func _ready() -> void:
	dialogue_rect.visible = false


func show_dialogue_text(dialogue_item: DialogueItem, duration: float) -> void:
	if _tween_text != null:
		_tween_text.kill()
	
	if _dialogue_label == null:
		return
	
	_tween_text = create_tween()
	dialogue_rect.visible = true
	_dialogue_label.text = dialogue_item.text
	_dialogue_label.visible_ratio = 0.0
	
	_tween_text.tween_property(_dialogue_label, "visible_ratio", 1.0, duration)
	_tween_text.finished.connect(
		func() -> void:
			await get_tree().create_timer(1.0).timeout
			dialogue_rect.visible = false
	)


func show_task_text(dialogue_item: DialogueItem, duration: float) -> void:
	if _tween_text != null:
		_tween_text.kill()
	
	if _current_task_label == null:
		return
	
	_tween_text = create_tween()
	_current_task_label.text = dialogue_item.text
	_current_task_label.visible_ratio = 0.0
	
	_tween_text.tween_property(_current_task_label, "visible_ratio", 1.0, duration)
