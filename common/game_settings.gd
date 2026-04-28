extends Node


var look_sensitivity := 0.0
var volume := 0.0
var is_fullscreen := false

var chance_for_rat := 0.1

func _ready() -> void:
	var rat_percentage := randf()
	
	#if rat_percentage < chance_for_rat:
		#get_tree().root.get_node()
