class_name Notebook
extends Control

@export var strength_value: Label
@export var dexterity_value: Label
@export var endurance_value: Label


func _on_player_stats_changed(stats: Stats) -> void:
	strength_value.text = str(stats.strength)
	dexterity_value.text = str(stats.dexterity)
	endurance_value.text = str(stats.endurance)
