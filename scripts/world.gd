extends Node2D


func _ready():
	var scene = get_tree().get_current_scene().get_name()
	
	print(scene)
	
	match scene:
		"l1":
			Dialogic.start("level1")

func _process(delta):
	pass
