extends Node2D

@export var override = false
@export var override_coords: Vector2

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		if not override:
			Global.setSpawn(global_position + Vector2(50,0))
		else:
			Global.setSpawn(override_coords)
		self.queue_free()
