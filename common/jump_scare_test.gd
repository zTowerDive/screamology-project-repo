class_name JumpScareTest extends Area3D

signal player_entered

@export var marker_3d: Marker3D
var player : PlayerController = null

func _ready() -> void:
	body_entered.connect(
		func(body: Node3D) -> void:
			if body is not PlayerController:
				return
			
			player = body as PlayerController
			
			player_entered.emit()
			player.turn_camera_towards(marker_3d.global_position, 1.0)
	)
