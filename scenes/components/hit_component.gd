class_name HitComponent
extends Area2D

signal hit(damage: int)

@export var stats: Stats
@export var attack: Attack
@export var effects: Array[Effect] = []


func _on_hit(area: Area2D) -> void:
	if area is HurtComponent:
		hit.emit(stats.strength)
