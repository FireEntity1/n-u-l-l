extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -900.0
var gravity = 1600
var slammed = false

var reset = false # death

var jumps = 2

var dir = 0

var dashing = false
var canDash = true

func _ready():
	pass

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
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
		$sprite.scale.x = lerp($sprite.scale.x, 1.25, 0.2)
		$sprite.scale.y = lerp($sprite.scale.y, 1.1, 0.2)
		slammed = false

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jumps -= 1
	elif Input.is_action_just_pressed("jump") and jumps > 0:
		jumps = 0
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("slam"):
		slammed = true
	if Input.is_action_just_pressed("slam") and is_on_floor():
		$sprite.scale.x = 1.5
		$sprite.scale.y = 0.8
	
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor():
		pass
	
	if direction:
		velocity.x = direction * SPEED
		dir = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dashing:
		velocity.x = dir*2600
		$sprite.scale.x = 3
		$sprite.scale.y = 0.8
		
	if Input.is_action_just_pressed("dash") and canDash:
		dashing = true
		canDash = false
		$dashTimer.start()
		$dashCool.start()
		
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
