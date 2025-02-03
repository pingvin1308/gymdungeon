class_name HurtComponent
extends Area2D

signal hurt(hit_damage: int)


func _on_area_entered(area: Area2D) -> void:
    if area is HitComponent:
        var hit_damage: int = 1
        hurt.emit(hit_damage)
    print(area is HitComponent)
