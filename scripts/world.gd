extends Node2D

func _ready():
	var scene = get_tree().get_current_scene().get_name()
	
	print(scene)
	
	match scene.to_int():
		pass

func _process(delta):
	pass
