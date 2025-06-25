extends CharacterBody2D

var can_input = true

const SPEED = 700.0
const JUMP_VELOCITY = -900.0
var gravity = 1600
var slammed = false

var hits = 1

var reset = false # death

var jumps = 2

var dir = 0

var dashing = false
var canDash = true

func _ready():
	$particles.emitting = true
	await get_tree().create_timer(0.5).timeout
	$particles.emitting = false
	hits = 0
	$camera.enabled = true
	if not Global.get_camera_mode():
		$camera.enabled = false

func _physics_process(delta):
	
	if hits > 3:
		var timeline = preload("res://dialogic/level7death.dtl")
		Dialogic.start_timeline(timeline)
	
	var direction = Input.get_axis("left", "right")
	
	Global.set_player_pos(self.position)
	
	if is_on_floor():
		jumps = 2
	
	if not is_on_floor():
	
		if not slammed:
			velocity.y += gravity * delta
		else:
			velocity.y = 5000
			$sprite.scale.x = 0.9
			$sprite.scale.y = 2
		
	else:
		slammed = false
		
	if not slammed and not dashing: 
		$sprite.scale.x = lerp($sprite.scale.x, 1.25, 0.2)
		$sprite.scale.y = lerp($sprite.scale.y, 1.1, 0.2)
		
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_input:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
	elif Input.is_action_just_pressed("jump") and jumps > 0 and can_input: 
		jumps = 0
		velocity.y = JUMP_VELOCITY
		$sprite.scale.x = 1.5
		$sprite.scale.y = 0.7
	
	if Input.is_action_just_pressed("slam") and can_input:
		slammed = true
	if Input.is_action_just_pressed("slam") and is_on_floor() and can_input:
		$sprite.scale.x = 1.5
		$sprite.scale.y = 0.8
	
	if direction and can_input:
		velocity.x = direction * SPEED
		dir = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dashing:
		velocity.x = dir*2600
		$sprite.scale.x = 3
		$sprite.scale.y = 0.8
		
	if Input.is_action_just_pressed("dash") and canDash and can_input:
		dashing = true
		canDash = false
		$dashTimer.start()
		$dashCool.start()
		$particles.process_material.direction = Vector3(dir*1,0,0)
		$particles.emitting = true
		await get_tree().create_timer(0.1).timeout
		$particles.emitting = false
		
	move_and_slide()

func kill(resetScene):
	if resetScene:
		get_tree().reload_current_scene()
	else:
		position = Global.getSpawn()

func _on_dash_cool_timeout():
	canDash = true

func _on_dash_timer_timeout():
	dashing = false
	$sprite.scale = Vector2(1.25,1.1)

func _on_area_entered(area: Area2D):
	print(area.name)
	if area.name == "killbox":
		position = Vector2(0,0)

func stop_input(time):
	can_input = false
	await get_tree().create_timer(time).timeout
	can_input = true

func teleport(coordinates: Vector2):
	position = coordinates

func hit_ball():
	hits += 1
	Global.setAberration(hits)
	
	Global.glitch(1)
