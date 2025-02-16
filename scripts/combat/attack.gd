class_name Attack
extends SequenceItem

@export var damage: int

var added_effects: Array[Effect] = []

func apply(character: CharacterBody2D) -> void:
	print("received damage: ", damage)
	for effect in added_effects:
		effect.apply(character)
	reset()


func add_effects(effects: Array[Effect]) -> void:
	for effect in effects:
		added_effects.push_back(effect)


func reset() -> void:
	added_effects.clear()
