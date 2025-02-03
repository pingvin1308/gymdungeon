class_name ChaseComponent
extends Area2D

signal start_chasing(player: Node2D)
signal stop_chasing()


func _on_body_entered(body: Node2D) -> void:
    if body is Player:
        start_chasing.emit(body)


func _on_body_exited(body: Node2D) -> void:
    if body is Player:
        stop_chasing.emit()
