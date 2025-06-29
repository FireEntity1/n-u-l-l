extends Node2D



func _on_enter_button_mouse_entered():
	$enter_button.flat = true
	print("entered")

func _on_enter_button_mouse_exited():
	$enter_button.flat = false


func _on_enter_button_button_up():
	$entersfx.play()
	Global.fade_to(1)
	await get_tree().create_timer(5).timeout
	Global.tv_static(2)
	await get_tree().create_timer(1).timeout
	Global.changeLevel(1)
