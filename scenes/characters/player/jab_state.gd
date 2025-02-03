extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D
@export var attack_range: int = 20

var player_height_offset: int = -15


func _ready() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO


func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	print("Mouse position: ", mouse_position)
	var direction = (mouse_position - player.global_position).normalized()
	hit_component_collision_shape.position = direction * attack_range + Vector2(0, player_height_offset)

	# if player.player_direction == Vector2.UP:
	# 	animated_sprite_2d.play("jab_up")
	# 	hit_component_collision_shape.position = Vector2(0, -38)
	# elif player.player_direction == Vector2.RIGHT:
	# 	animated_sprite_2d.play("jab_right")
	# 	hit_component_collision_shape.position = Vector2(18, -15)
	# elif player.player_direction == Vector2.LEFT:
	# 	animated_sprite_2d.play("jab_left")
	# 	hit_component_collision_shape.position = Vector2(-18, -15)
	# elif player.player_direction == Vector2.DOWN:
	# 	animated_sprite_2d.play("jab_down")
	# 	hit_component_collision_shape.position = Vector2(0, 12)
	# else:
	# 	animated_sprite_2d.play("jab_down")
	# 	hit_component_collision_shape.position = Vector2(0, 10)
		
	hit_component_collision_shape.set_deferred("disabled", false)



func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.set_deferred("disabled", true)
