extends NodeState

@export var enemy: BasicEnemy


func _on_physics_process(_delta: float) -> void:
	if enemy.is_chasing and enemy.target_player != null:
		var player = enemy.target_player
		var direction = (player.position - enemy.position).normalized()
		enemy.velocity = direction * enemy.speed
		enemy.move_and_slide()


func _on_next_transitions() -> void:
	if enemy.is_knocked_back:
		transition.emit("Knockback")
	elif enemy.is_chasing and enemy.position.distance_to(enemy.target_player.position) <= enemy.attack_range:
		transition.emit("Attack")
	else:
		transition.emit("Idle")

