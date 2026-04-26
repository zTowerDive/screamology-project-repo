class_name JumpScareTest extends Area3D
@onready var marker_3d: Marker3D = $Marker3D

func _ready() -> void:
	body_entered.connect(
		func(body: Node3D) -> void:
			if body is not PlayerController:
				return
			
			var player := body as PlayerController
			
			player.turn_camera_towards(marker_3d.global_position, .5)
	)
