extends Node2D

@export var color: int

@onready var node = $layer/color

func _ready():
	match color:
		1: node.color = Color(0,0,0)
		0: node.color = Color(255,255,255)
	print("ready to fade")

func _process(delta):
	node.modulate.a += delta/4
