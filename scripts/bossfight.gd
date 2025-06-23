extends Node2D

var phase = 1

var attacks = ["ball"]

var entityCASpread = 0.03
var entityCAUp = true
var target = 0.04

func _ready():
	pass

func _physics_process(delta):
	# chromatic aberration for central orb
	
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
	
	# actual attacks
	var current = attacks.pick_random()
	
	match phase:
		1:
			attacks = ["ball"]
	
	match current:
		"ball":
			pass
	
