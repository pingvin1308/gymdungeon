class_name Effect
extends SequenceItem

@export var effect_type: Type

func apply(body: CharacterBody2D) -> void:
	if effect_type == Type.Knockback:
		if body.has_signal(&"knockback"):
			body.knockback.emit()

	print("received effect: ", name)


enum Type {
	Knockback,
	Slow
}
