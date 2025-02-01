class_name HurtComponent
extends Area2D

signal hurt(hit_damage: int)


func _on_area_entered(_area: Area2D) -> void:
    print(_area)
    var hit_damage: int = 1
    hurt.emit(hit_damage)
