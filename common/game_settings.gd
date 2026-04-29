extends Node


var look_sensitivity := 0.005:
	set = set_look_sensitivity
var volume := 0.0:
	set = set_game_volume
var is_fullscreen := true

var chance_for_rat := 0.1

func _ready() -> void:
	set_game_volume(volume)
	set_look_sensitivity(look_sensitivity)
	set_fullscreen(is_fullscreen)

func set_game_volume(new_value: float) -> void:
	volume = new_value
	AudioServer.set_bus_volume_linear(0, volume)
	print("volume changed")


func set_look_sensitivity(new_value: float) -> void:
	look_sensitivity = new_value
	print("sensitivity changed")


func set_fullscreen(new_value: bool) -> void:
	is_fullscreen = new_value
	
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
