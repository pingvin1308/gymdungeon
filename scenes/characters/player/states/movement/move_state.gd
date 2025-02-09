extends MovementState

@export var speed: int = 100

var direction: Vector2 = Vector2.ZERO
var lerp_speed: float = 10.0
var lerp_velocity_value_on_floor: float = 16


func _enter() -> void:
	player.velocity = Vector2()


func _update(delta: float) -> void:
	var input_direction := _get_input_direction()
	_move_character(input_direction, delta)
	_play_animation(input_direction)


func _move_character(input_direction: Vector2, delta: float) -> void:
	if input_direction.is_zero_approx():
		finished.emit("idle")

	direction = lerp(direction, Vector2(input_direction.x, input_direction.y).normalized(), delta * lerp_speed)

	var calculated_velocity := player.velocity
	var move_x := direction.x * speed
	var move_y := direction.y * speed
	if direction:
		calculated_velocity = Vector2(move_x, move_y)
	else:
		calculated_velocity = Vector2(
			lerp(calculated_velocity.x, move_x, delta * lerp_velocity_value_on_floor),
			lerp(calculated_velocity.y, move_y, delta * lerp_velocity_value_on_floor)
		)

	player.direction = direction
	player.velocity = calculated_velocity
	player.move_and_slide()


func _handle_input(event: InputEvent) -> void:
	return super._handle_input(event)


func _play_animation(input_direction: Vector2) -> void:
	var animation_name = _get_animation_name(input_direction)
	if not animation_name.is_empty():
		animation_player.play(animation_name)


func _get_animation_name(input_direction: Vector2) -> String:
	if input_direction.y > 0.5 and input_direction.x > 0.5:
		return "walk_right"
	elif input_direction.y < 0.5 and input_direction.x > 0.5:
		return "walk_right"
	elif input_direction.x > 0.5:
		return "walk_right"
	elif input_direction.y > -0.5 and input_direction.x < -0.5:
		return "walk_left"
	elif input_direction.y < -0.5 and input_direction.x < -0.5:
		return "walk_left"
	elif input_direction.x < -0.5:
		return "walk_left"
	if input_direction.y > 0.5:
		return "walk_down"
	elif input_direction.y < -0.5:
		return "walk_up"
	elif input_direction.x > 0.5:
		return "walk_right"
	return ""
