extends Node2D

@export var reset = false

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		body.kill(reset)
