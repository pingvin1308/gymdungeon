class_name Stats
extends Node

signal stats_changed()

@export var strength: int = 1:
	set(value):
		strength = value
		stats_changed.emit()

@export var dexterity: int = 1:
	set(value):
		dexterity = value
		stats_changed.emit()

@export var endurance: int = 1:
	set(value):
		endurance = value
		stats_changed.emit()


func _on_training_plan_finished(strength_from_plan: int, dexterity_from_plan: int, endurance_from_plan: int) -> void:
	strength += strength_from_plan
	dexterity += dexterity_from_plan
	endurance += endurance_from_plan
