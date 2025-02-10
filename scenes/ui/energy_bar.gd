class_name EnergyBar
extends HBoxContainer

const ENERGY = preload("res://scenes/ui/energy.tscn")
const MAX_POSSIBLE_ENERGY = 10


@export var max_energy_label: int:
	set(value):
		max_energy_label = min(value, MAX_POSSIBLE_ENERGY)
		_update_energy_containers()

@export var current_energy_label: int:
	set(value):
		current_energy_label = clamp(value, 0, max_energy_label)
		_update_energy_display()


func _update_energy_containers() -> void:
	for child in get_children():
		remove_child(child)
		#child.queue_free()

	for energy_index in range(max_energy_label):
		var energy_scene := ENERGY.instantiate() as Energy
		add_child(energy_scene)

	_update_energy_display()


func _update_energy_display() -> void:

	for energy_index in range(max_energy_label):
		var is_visible = true if energy_index < current_energy_label else false
		var energy_container := get_child(energy_index)
		if energy_container:
			energy_container.set_value(is_visible)
