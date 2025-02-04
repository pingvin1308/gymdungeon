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
        var player = enemy.target_player
        direction = (enemy.position - player.position).normalized()
        print("Knockback direction: ", direction)
        velocity = direction * strength
        duration = 0.1


func _on_physics_process(_delta: float) -> void:
    if enemy.target_player == null:
        return

    if duration > 0:
        duration -= _delta
        # enemy.velocity = velocity
        # enemy.move_and_slide()

        # Пробуем переместить противника с учетом коллизий
        var collision = enemy.move_and_collide(velocity * _delta)
        if collision:
            pass
            # Если столкновение произошло, корректируем вектор скорости:
            # "Скользим" по нормали столкновения, чтобы не проскакивать через объект
            # velocity = velocity.slide(collision.get_normal())
            # Можно также уменьшить силу knockback'а, например:
            # velocity = -direction * strength * 0.5
        enemy.velocity = velocity


func _on_next_transitions() -> void:
    if duration <= 0:
        enemy.is_knocked_back = false
        transition.emit("Idle")
