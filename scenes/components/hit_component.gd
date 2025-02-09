class_name HitComponent
extends Area2D

signal hit(damage: int)

@onready var stats: Stats = $"../Stats"


func _on_hit(area: Area2D) -> void:
	if area is HurtComponent:
		hit.emit(stats.strength)
