class_name VisionArea3D extends Area3D

signal player_detected

signal player_lost

var focused_body : CharacterBody3D = null


func _ready() -> void:
	body_entered.connect(
		func(body: Node3D) -> void:
			if body is not PlayerController:
				return
			
			player_detected.emit()
			
			focused_body = body as PlayerController
	)
	
	body_exited.connect(
		func(body: Node3D) -> void:
			if body is not PlayerController:
				return
			
			player_lost.emit()
			
			focused_body = null
	)

func get_focused_body() -> Node3D:
	return focused_body
