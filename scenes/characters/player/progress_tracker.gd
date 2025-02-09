class_name TrainingPlanProgressTracker
extends Node

signal on_finished(strength: int, dexterity: int, endurance: int)

@export var active_trainig_plan: TrainingPlan

var protein: int = 0:
	set(value):
		protein = value
		progress["protein"] = protein
		_on_change()

var attack_evaded: int = 0:
	set(value):
		attack_evaded = value
		progress["attack_evaded"] = attack_evaded
		_on_change()

var damage_consumed: int = 0:
	set(value):
		damage_consumed = value
		progress["damage_consumed"] = damage_consumed
		_on_change()

var exercise_machine_A: int = 0:
	set(value):
		exercise_machine_A = value
		progress["exercise_machine_A"] = exercise_machine_A
		_on_change()

var damage_dealt: int = 0:
	set(value):
		damage_dealt = value
		progress["damage_dealt"] = damage_dealt
		_on_change()

var progress: Dictionary
var finished_plans: Dictionary


func _on_change() -> void:
	if finished_plans.get(active_trainig_plan.name):
		return

	if _is_finished():
		finished_plans[active_trainig_plan.name] = true
		on_finished.emit(5, 1, 1)


func _is_finished() -> bool:
	var conditioins_count = active_trainig_plan.conditions.size()
	for condition_name in active_trainig_plan.conditions:
		var current_value = progress.get(condition_name, 0)
		var required_value = active_trainig_plan.conditions[condition_name]

		if required_value > current_value:
			return false

	return true
