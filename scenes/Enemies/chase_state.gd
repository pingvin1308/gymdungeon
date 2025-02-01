extends NodeState

@export var enemy: BasicEnemy


func _on_physics_process(_delta: float) -> void:
	if enemy.is_chasing:
		var player = enemy.target_player
		enemy.velocity = (player.position - enemy.position).normalized() * enemy.speed
		enemy.move_and_slide()


func _on_next_transitions() -> void:
	if !enemy.is_chasing:
		transition.emit("Idle")

