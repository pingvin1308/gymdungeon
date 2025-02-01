class_name ChaseComponent
extends Area2D

signal start_chasing(player: Node2D)
signal stop_chasing()


func _on_body_entered(player: Node2D) -> void:
    start_chasing.emit(player)


func _on_body_exited(_body: Node2D) -> void:
    stop_chasing.emit()
