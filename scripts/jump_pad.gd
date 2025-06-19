extends Node2D


func _on_area_body_entered(body):
	if body is CharacterBody2D:
		body.velocity.y = -2000
