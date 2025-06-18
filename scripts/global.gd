extends Node

var killed = false
var reset = false

var respawn = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	pass

func kill(resetScene):
	killed = true
	reset = resetScene

func get_kill_status():
	if killed == true:
		killed = false
		return true
	else: 
		return false

func shouldReset():
	return reset

func setSpawn(spawn: Vector2):
	respawn = spawn

func getSpawn():
	return respawn

func changeLevel(level):
	get_tree().change_scene_to_file("res://levels/level" + str(level) + ".tscn")
