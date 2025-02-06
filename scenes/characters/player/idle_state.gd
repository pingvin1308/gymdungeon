extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(_delta: float) -> void:
	if player.direction.y > 0.5:
		animated_sprite_2d.play("idle_down")
	elif player.direction.y < -0.5:
		animated_sprite_2d.play("idle_up")
	elif player.direction.x > 0.5:
		animated_sprite_2d.play("idle_right")
	elif player.direction.x < -0.5:
		animated_sprite_2d.play("idle_left")
	else:
		animated_sprite_2d.play("idle_down")


func _on_next_transitions() -> void:
	if player.direction != Vector2.ZERO:
		transition.emit("Walk")
	# if GameInputEvents.is_dash():
	# 	transition.emit("Dash")
	
	# if GameInputEvents.is_movement_input():
	# 	transition.emit("Walk")
		
	# if GameInputEvents.is_hit():
	# 	transition.emit("Jab")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
