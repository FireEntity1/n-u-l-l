extends Node2D



func _on_enter_button_mouse_entered():
	$enter_button.flat = true
	print("entered")

func _on_enter_button_mouse_exited():
	$enter_button.flat = false


func _on_enter_button_button_up():
	Global.changeLevel(1)
