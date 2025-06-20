extends Node2D

@export var color: int

func _ready():
	match color:
		1: $layer/color.color = Color(0,0,0)
		0: $layer/color.color = Color(255,255,255)

func _process(delta):
	$layer/color.modulate.a += delta/4
