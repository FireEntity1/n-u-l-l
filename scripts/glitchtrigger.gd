extends Node2D

@export var duration = 1

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		Global.glitch(duration)
		queue_free()
