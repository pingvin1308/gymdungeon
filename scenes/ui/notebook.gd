class_name Notebook
extends Control

@export var strength_value: Label
@export var dexterity_value: Label
@export var endurance_value: Label
@export var stats_menu: PanelContainer
@export var fitness_menu: PanelContainer


func _ready() -> void:
	_toggle_node_process_node(stats_menu, false)
	_toggle_node_process_node(fitness_menu, false)


func _on_player_stats_changed(stats: Stats) -> void:
	strength_value.text = str(stats.strength)
	dexterity_value.text = str(stats.dexterity)
	endurance_value.text = str(stats.endurance)


func _on_stats_pressed() -> void:
	_toggle_node_process_node(stats_menu, true)
	_toggle_node_process_node(fitness_menu, false)


func _on_fitness_pressed() -> void:
	_toggle_node_process_node(stats_menu, false)
	_toggle_node_process_node(fitness_menu, true)


func _toggle_node_process_node(node: Node, toggle_visible: bool):
	node.visible = toggle_visible
	if not node.visible:
		node.process_mode = PROCESS_MODE_DISABLED
	else:
		node.process_mode = PROCESS_MODE_INHERIT
