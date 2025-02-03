extends NodeState

@export var enemy: BasicEnemy
@export var hit_component_collision_shape: CollisionShape2D
@export var attack_range: int = 20
@export var attack_cooldown: float = 0.5

var enemy_height_offset: int = -15
var attack_timer: float = 0.0


func _ready() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO


func _on_enter() -> void:
	if enemy.target_player == null:
		return

	if attack_timer <= 0:
		var player_position = enemy.target_player.global_position
		var direction = (player_position - enemy.global_position).normalized()
		hit_component_collision_shape.position = direction * attack_range + Vector2(0, enemy_height_offset)
		hit_component_collision_shape.set_deferred("disabled", false)
		attack_timer = attack_cooldown


func _on_physics_process(_delta: float) -> void:
	attack_timer -= _delta


func _on_next_transitions() -> void:
	if enemy.is_chasing:
		transition.emit("Chase")
	else:
		transition.emit("Idle")


func _on_exit() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)