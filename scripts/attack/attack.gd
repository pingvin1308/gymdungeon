class_name Attack
extends SequenceItem

@export var damage: int

func apply(character: CharacterBody2D) -> void:
	print("received damage: ", damage)
	#character.
