extends EnemyState


func _update(delta: float) -> void:
	if enemy.is_chasing and enemy.target_player != null:
		var player = enemy.target_player
		var direction = (player.position - enemy.position).normalized()
		enemy.velocity = direction * enemy.speed
		enemy.move_and_slide()

		if enemy.position.distance_to(enemy.target_player.position) <= enemy.attack_range:
			finished.emit("attack")
