extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed: int = 75


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(_delta: float) -> void:
	if player.direction.y > 0.5:
		animated_sprite_2d.play("walk_down")
	elif player.direction.y < -0.5:
		animated_sprite_2d.play("walk_up")
	elif player.direction.x > 0.5:
		animated_sprite_2d.play("walk_right")
	elif player.direction.x < -0.5:
		animated_sprite_2d.play("walk_left")


func _on_next_transitions() -> void:
	#if GameInputEvents.is_dash():
		#transition.emit("Dash")
	#
	#if GameInputEvents.is_hit():
		#transition.emit("Jab")

	if abs(player.velocity.y) < 5 and abs(player.velocity.x) < 5:
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
