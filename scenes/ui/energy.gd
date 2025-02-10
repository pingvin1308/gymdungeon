class_name Energy
extends Control

@export var full_energy: TextureRect
@export var empty_energy: TextureRect


func _ready() -> void:
	set_value(true)


func set_value(value: bool) -> void:
	full_energy.visible = value
	empty_energy.visible = !value
