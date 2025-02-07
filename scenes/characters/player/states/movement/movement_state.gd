class_name MovementState
extends PlayerState


func _get_input_direction() -> Vector2:
	var input_direction := Vector2(
		Input.get_axis(&"walk_left", &"walk_right"),
		Input.get_axis(&"walk_up", &"walk_down")
	)
	return input_direction


func _handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("dash"):
		finished.emit("dash")
	return super._handle_input(event)
