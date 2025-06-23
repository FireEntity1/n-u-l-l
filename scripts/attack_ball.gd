extends Node2D

func _on_area_body_entered(body):
	body.hit_ball()
