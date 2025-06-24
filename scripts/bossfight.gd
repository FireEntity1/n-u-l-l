extends Node2D

var phase = 1
var cycles = 0

var attacks = ["ball"]

var ball_scene = preload("res://components/attack_ball.tscn")

var entityCASpread = 0.03
var entityCAUp = true
var target = 0.04

func _ready():
	pass

func _physics_process(delta):
	$aberration.material.set_shader_parameter("spread", Global.aberration)
	if entityCAUp:
		if entityCASpread > target:
			entityCAUp = false
		target = 0.03
		entityCASpread += 0.0008
	else:
		if entityCASpread < target:
			entityCAUp = true
		target = 0.02
		entityCASpread -= 0.0008
	$entity_aberration.material.set_shader_parameter("spread", entityCASpread)

func _on_attack_timer_timeout():
	var current = attacks.pick_random()
	
	match phase:
		1:
			attacks = ["ball"]
		2:
			attacks = ["ball", "big_spinny"]
		
	match current:
		"ball":
			var instance = ball_scene.instantiate()
			instance.get_node("body").position = Vector2(292, 1371)
			$entity.add_child(instance)
			cycles += 1
			print("added")
