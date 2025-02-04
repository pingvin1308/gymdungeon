extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D
@export var attack_range: int = 20

var player_height_offset: int = -15
@export var dash_distance: float = 30.0
@export var dash_duration: float = 0.2
@export var attack_trigger_range: float = 100.0

var is_dashing: bool = false

func _ready() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO

func get_closest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemies")
	var closest_enemy: Node2D = null
	var closest_distance = INF
	for enemy in enemies:
		var dist = player.global_position.distance_to(enemy.global_position)
		if dist < closest_distance:
			closest_distance = dist
			closest_enemy = enemy
	return closest_enemy

func dash_to_closest_enemy(enemy: CharacterBody2D) -> void:
	var target_position = player.global_position.move_toward(enemy.global_position, dash_distance)
	
	is_dashing = true
	var tween = get_tree().create_tween()
	tween.tween_property(player, "global_position", target_position, dash_duration)
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_OUT)
	tween.connect("finished", Callable(self, "_on_dash_finished"))

func _on_enter() -> void:
	# var closest_enemy = get_closest_enemy()
	# var direction: Vector2

	# if closest_enemy and player.global_position.distance_to(closest_enemy.global_position) <= attack_trigger_range:
	# 	direction = (closest_enemy.global_position - player.global_position).normalized()
	# 	dash_to_closest_enemy(closest_enemy)
	# else:
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

func _on_dash_finished() -> void:
	is_dashing = false

func _on_next_transitions() -> void:
	if not animated_sprite_2d.is_playing():
		transition.emit("Idle")

func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.set_deferred("disabled", true)
