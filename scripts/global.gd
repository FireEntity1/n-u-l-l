extends Node

var killed = false

var faded = false
var fadeNode

var aberration = 0.02

var playerCamera = true

var player_pos = Vector2(0,0)

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
	faded = true
	var scene = preload("res://components/fade_to.tscn")
	fadeNode = scene.instantiate()
	fadeNode.color = color
	get_tree().root.add_child(fadeNode)

func remove_fade():
	fadeNode.queue_free()

func tv_static(duration):
	var tv_static = preload("res://components/static.tscn").instantiate()
	get_tree().root.add_child(tv_static)
	await get_tree().create_timer(duration).timeout
	tv_static.queue_free()

func teleport_player(x,y):
	pass

func disable_camera():
	playerCamera = false

func get_camera_mode():
	return playerCamera

func get_player_pos():
	return player_pos

func set_player_pos(position: Vector2):
	player_pos = position

func setAberration(value):
	aberration = value
	print(aberration)
