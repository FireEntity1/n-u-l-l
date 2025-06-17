extends Node

var killed = false

func _ready():
	pass

func _process(delta):
	pass

func kill():
	killed = true

func get_kill_status():
	if killed == true:
		killed = false
		return true
	else: 
		return false
