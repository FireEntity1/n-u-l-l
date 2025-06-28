extends Node2D

var volume = 10

func _ready():
	pass
	

func _physics_process(delta):
	volume = Global.volume
	$layer/volumebar.visible = Global.volVisible
	$layer/volumebar.value = volume
