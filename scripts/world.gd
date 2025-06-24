extends Node2D

func _ready():
	var scene = get_tree().get_current_scene().get_name()
	
	if scene == "l7":
		Global.disable_camera()
		$Dialogic/DialogicAutoAdvance.enabled = true
