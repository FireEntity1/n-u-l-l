extends Node

@export var timeline: DialogicTimeline

func _on_area_body_entered(body):
	if body is CharacterBody2D:
		Dialogic.start(timeline)
		queue_free()
