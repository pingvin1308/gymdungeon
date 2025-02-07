extends MovementState

var last_direction: Vector2 = Vector2.ZERO


func _enter() -> void:
	var animation_name = _get_animation_name(last_direction);
	animated_sprite.play(animation_name)


func _update(_delta) -> void:
	last_direction = _get_input_direction()
	if last_direction:
		finished.emit("move")


func _handle_input(event: InputEvent) -> void:
	return super._handle_input(event)


func _get_animation_name(direction: Vector2) -> String:
	if direction.y > 0.5:
		return "idle_down"
	elif direction.y < -0.5:
		return "idle_up"
	elif direction.x > 0.5:
		return "idle_right"
	elif direction.x < -0.5:
		return "idle_left"
	else:
		return "idle_down"
