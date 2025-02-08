class_name HurtComponent
extends Area2D

signal hurt(hit_damage: int, global_position: Vector2)


func _on_area_entered(area: Area2D) -> void:
	if area is HitComponent:
		var hit_damage: int = area.damage
		hurt.emit(hit_damage, area.global_position)
