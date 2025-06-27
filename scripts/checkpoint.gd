extends Node2D

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		Global.respawn = global_position + Vector2(50,0)
		self.queue_free()
