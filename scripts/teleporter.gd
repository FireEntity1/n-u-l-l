extends Node2D

@export var coordinates : Vector2

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		body.position = coordinates
		self.queue_free()
