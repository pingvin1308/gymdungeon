extends NodeState

@export var enemy: BasicEnemy
@export var strength: int = 250

var velocity: Vector2 = Vector2.ZERO
var duration: float = 0.0
var direction: Vector2


func _on_enter() -> void:
	if enemy.target_player == null:
		return

	if duration <= 0:
		var player: = enemy.target_player
		direction = (enemy.position - player.position).normalized()
		print("Knockback direction: ", direction)
		velocity = direction * strength
		duration = 0.1


func _on_physics_process(_delta: float) -> void:
	if enemy.target_player == null:
		return

	if duration > 0:
		duration -= _delta

		var collision: = enemy.move_and_collide(velocity * _delta)
		if collision:
			pass
		enemy.velocity = velocity


func _on_next_transitions() -> void:
	if duration <= 0:
		enemy.is_knocked_back = false
		transition.emit("Idle")
