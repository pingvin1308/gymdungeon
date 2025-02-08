extends EnemyState

@onready var attack_cooldown_timer: Timer = $AttackCooldownTimer

@export var hit_component_collision_shape: CollisionShape2D
@export var attack_cooldown: float = 0.5

var is_hitbox_collides: bool = false
var enemy_height_offset: int = -15


func _ready() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO
	attack_cooldown_timer.timeout.connect(_on_attack_cooldown_timer_timeout)


func _enter() -> void:
	if enemy.target_player == null:
		finished.emit("idle")
		return

	attack_cooldown_timer.start(1.0)


func _exit() -> void:
	hit_component_collision_shape.position = Vector2.ZERO
	hit_component_collision_shape.set_deferred("disabled", true)
	attack_cooldown_timer.stop()


func _on_attack_cooldown_timer_timeout() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	if enemy.position.distance_to(enemy.target_player.position) <= enemy.attack_range:
		var player_position = enemy.target_player.global_position
		var direction = (player_position - enemy.global_position).normalized()
		hit_component_collision_shape.global_position = player_position
		hit_component_collision_shape.set_deferred("disabled", false)
	else:
		finished.emit("chase")
