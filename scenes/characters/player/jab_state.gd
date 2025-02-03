extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D


func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2.ZERO


func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("jab_up")
		hit_component_collision_shape.position = Vector2(0, -31)
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("jab_right")
		hit_component_collision_shape.position = Vector2(13, -15)
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("jab_left")
		hit_component_collision_shape.position = Vector2(-13, -15)
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("jab_down")
		hit_component_collision_shape.position = Vector2(0, 4)
	else:
		animated_sprite_2d.play("jab_down")
		hit_component_collision_shape.position = Vector2(0, 4)
		
	hit_component_collision_shape.disabled = false


func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.disabled = true
