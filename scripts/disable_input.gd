extends Node2D

@export var time: int

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		body.stop_input(time)
		self.queue_free()
