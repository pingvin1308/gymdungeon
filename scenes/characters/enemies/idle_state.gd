extends NodeState

@export var enemy: BasicEnemy


func _on_next_transitions() -> void:
	if enemy.is_knocked_back:
		transition.emit("Knockback")
	elif enemy.is_chasing and enemy.target_player != null:
		transition.emit("Chase")
	else:
		transition.emit("Idle")
