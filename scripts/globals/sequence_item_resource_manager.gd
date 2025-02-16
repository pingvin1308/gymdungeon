extends Node

@onready var resources: Dictionary = {
	&"jab": func():
		var jab: Attack = Attack.new()
		jab.icon = "res://assets/ui/icons/attacks_jab.png"
		jab.name = "jab"
		jab.damage = 1
		return jab,

	&"knockback": func():
		var knockback: Effect = Effect.new()
		knockback.icon = "res://assets/ui/icons/effects_knockback.png"
		knockback.name = "knockback"
		knockback.effect_type = Effect.Type.Knockback
		return knockback
}

func get_resource(resource_name: StringName) -> SequenceItem:
	if not resources.has(resource_name):
		return null

	return resources[resource_name].call()


func get_all_resources() -> Array[SequenceItem]:
	var result: Array[SequenceItem] = []
	for resource_name in resources:
		var sequence_item = resources[resource_name]
		result.push_back(sequence_item.call())
	return result
