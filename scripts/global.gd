extends Node

var killed = false

var volume = 10
var volVisible = false


var is_attacking = false

var bgshader = 8

var volTimer

var faded = false
var fadeNode

var aberration = 0.02

var playerCamera = true

var player_pos = Vector2(0,0)

var respawn = Vector2(0,0)

func _ready():
	volTimer = Timer.new()
	volTimer.wait_time = 1
	volTimer.timeout.connect(_on_vol_hide_timeout)
	add_child(volTimer)

func _process(delta):
	if Input.is_action_just_pressed("volUp"):
		changeVolume(true)
	elif Input.is_action_just_pressed("volDown"):
		changeVolume(false)

func setbgshader(value):
	bgshader = value

func get_kill_status():
	if killed == true:
		killed = false
		return true
	else: 
		return false

func setSpawn(spawn: Vector2):
	respawn = spawn

func getSpawn():
	print(respawn)
	return respawn

func changeLevel(level):
	get_tree().change_scene_to_file("res://levels/level" + str(level) + ".tscn")

func glitch(duration):
	var glitch_scene = preload("res://components/glitch_screen.tscn")
	var glitch = glitch_scene.instantiate()
	get_tree().root.add_child(glitch)
	clearGlitch(duration,glitch)

func clearGlitch(duration, glitch):
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
	
func enable_camera():
	playerCamera = true

func get_camera_mode():
	return playerCamera

func get_player_pos():
	return player_pos

func set_player_pos(position: Vector2):
	player_pos = position

func setAberration(value: float):
	aberration = value/20

func setAttacking(value):
	is_attacking = value

func quit():
	get_tree().quit()

func changeVolume(up: bool):
	if volume < 10 and up:
			volume += 1
	elif volume > 0 and not up: 
		volume -= 1
	var normalized = volume/10.00
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(normalized))
	volVisible = true
	volTimer.stop()
	volTimer.start()

func _on_vol_hide_timeout():
	volVisible = false

func stopInput(time: float):
	var scene = preload("res://components/disable_input.tscn")
	var instance = scene.instantiate()
	instance.time = time
	instance.position = player_pos
	add_child(instance)
