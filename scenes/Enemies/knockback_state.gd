extends NodeState

@export var enemy: BasicEnemy

var knockback_velocity = Vector2.ZERO
var knockback_duration = 0.0
var knockback_strength = 250


func _on_enter() -> void:
    if enemy.target_player == null:
        return
    
    var player = enemy.target_player
    var direction = (enemy.position - player.position).normalized()
    knockback_velocity = direction * knockback_strength
    knockback_duration = 0.2


func _on_physics_process(_delta: float) -> void:
    if enemy.target_player == null:
        return

    if knockback_duration > 0:
        knockback_duration -= _delta
        knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, 500 * _delta)
        enemy.velocity = knockback_velocity
        enemy.move_and_slide()

    enemy.is_knocked_back = false


func _on_next_transitions() -> void:
    transition.emit("Idle")
