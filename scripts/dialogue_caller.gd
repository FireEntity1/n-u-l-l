extends Node

@export var timeline: DialogicTimeline

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_body_entered(body):
	if body is CharacterBody2D:
		Dialogic.start(timeline)
		queue_free()
