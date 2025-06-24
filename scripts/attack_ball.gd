extends CharacterBody2D

var direction
var target_pos
var homing

func _ready():
	global_position = Vector2.ZERO
	target_pos = Global.get_player_pos() - Vector2(389, 479)
	direction = (target_pos - global_position).normalized()
	homing = true

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		body.hit_ball()
		queue_free()

func _physics_process(delta):
	if homing:
		direction = (target_pos - global_position).normalized()
	
	self.velocity = direction * 1300
	
	move_and_slide()
	
	if position.x > 3000 or position.x < -3000 or position.y > 3000 or position.y < -3000:
		queue_free()


func _on_initial_homing_timeout():
	homing = false
