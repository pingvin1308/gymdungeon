class_name SequenceItemContainer
extends Button

#@onready var icon: TextureRect = $Icon
signal sequence_item_selected(index: int)


var index: int = 0
var sequence_item: SequenceItem:
	set(value):
		sequence_item = value
		icon = load(value.icon)


func enable() -> void:
	if material is ShaderMaterial:
		material.set_shader_parameter("is_visible", true)


func disable() -> void:
	if material is ShaderMaterial:
		material.set_shader_parameter("is_visible", false)

func _pressed() -> void:
	sequence_item_selected.emit(index)
