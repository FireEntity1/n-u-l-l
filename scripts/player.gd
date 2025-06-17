extends CharacterBody2D


const SPEED = 700.0
const JUMP_VELOCITY = -700.0
var gravity = 1600
var slammed = false

var dir = 0

var dashing = false
var canDash = true

func _ready():
	pass

func _physics_process(delta):
	var direction = Input.get_axis("left", "right")
	
	if not is_on_floor():
		if not slammed:
			velocity.y += gravity * delta
		else:
			velocity.y += 30 * gravity * delta
			
		if $sprite.scale.x > 0.9:
			$sprite.scale.x -= 0.08
		if $sprite.scale.y < 1.3:
			$sprite.scale.y += 0.08
	else:
		if $sprite.scale.x < 1.25:
			$sprite.scale.x += 0.05
		if $sprite.scale.y > 1.1:
			$sprite.scale.y -= 0.1
		slammed = false
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("slam"):
		slammed = true
		
	if Global.get_kill_status():
		get_tree().reload_current_scene()
	
	if (Input.is_action_pressed("left") or Input.is_action_pressed("right")) and is_on_floor():
		pass
	
	if direction:
		velocity.x = direction * SPEED
		dir = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if dashing:
		velocity.x = dir*2600
		
	if Input.is_action_just_pressed("dash") and canDash:
		dashing = true
		canDash = false
		$dashTimer.start()
		$dashCool.start()
		
	move_and_slide()


func _on_dash_cool_timeout():
	canDash = true

func _on_dash_timer_timeout():
	dashing = false

func _on_area_entered(area: Area2D):
	print(area.name)
	if area.name == "killbox":
		position = Vector2(0,0)
