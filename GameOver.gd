extends CanvasLayer



func  _input(event: InputEvent) -> void:
	if event.is_action_pressed("Attack"):
		get_tree().reload_current_scene()
	if event.is_action_pressed("Defend"):
		get_tree().reload_current_scene()
