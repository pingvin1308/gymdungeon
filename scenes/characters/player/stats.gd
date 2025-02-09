class_name Stats
extends Node

@export var strength: int = 1
@export var dexterity: int = 1
@export var endurance: int = 1


func _on_training_plan_finished(strength_from_plan: int, dexterity_from_plan: int, endurance_from_plan: int) -> void:
	strength += strength_from_plan
	dexterity += dexterity_from_plan
	endurance += endurance_from_plan
