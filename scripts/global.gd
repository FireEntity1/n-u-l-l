extends Node

var killed = false

var respawn = Vector2(0,0)

func _ready():
	pass

func _process(delta):
	pass

func get_kill_status():
	if killed == true:
		killed = false
		return true
	else: 
		return false

func setSpawn(spawn: Vector2):
	respawn = spawn

func getSpawn():
	return respawn

func changeLevel(level):
	get_tree().change_scene_to_file("res://levels/level" + str(level) + ".tscn")

func glitch(duration):
	var glitch_scene = preload("res://components/glitch_screen.tscn")
	var glitch = glitch_scene.instantiate()
	get_tree().root.add_child(glitch)
	await get_tree().create_timer(duration).timeout
	glitch.queue_free()

func clear_dialogue():
	Dialogic.end_timeline()

func fade_to(color):
	var scene = preload("res://components/fade_to.tscn")
	var instance = scene.instantiate()
	instance.color = color
	get_tree().root.add_child(instance)

func tv_static(duration):
	var tv_static = preload("res://components/static.tscn").instantiate()
	get_tree().root.add_child(tv_static)
	await get_tree().create_timer(duration).timeout
	tv_static.queue_free()
