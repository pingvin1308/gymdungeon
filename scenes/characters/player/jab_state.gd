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
	var direction = (mouse_position - player.global_position).normalized()
	hit_component_collision_shape.position = direction * attack_range + Vector2(0, player_height_offset)

	if direction.y > 0.5:
		animated_sprite_2d.play("jab_down")
	elif direction.y < -0.5:
		animated_sprite_2d.play("jab_up")
	elif direction.x > 0.5:
		animated_sprite_2d.play("jab_right")
	elif direction.x < -0.5:
		animated_sprite_2d.play("jab_left")
	else:
		animated_sprite_2d.play("jab_down")
		
	hit_component_collision_shape.set_deferred("disabled", false)



func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.set_deferred("disabled", true)
