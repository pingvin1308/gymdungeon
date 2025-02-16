class_name Notebook
extends Control

@export var stats_menu: StatsMenu
@export var moveset_menu: PanelContainer


func _ready() -> void:
	_toggle_node_process_node(stats_menu, true)
	_toggle_node_process_node(moveset_menu, false)


func update_stats(stats: Stats) -> void:
	stats_menu.strength_value.text = str(stats.strength)
	stats_menu.dexterity_value.text = str(stats.dexterity)
	stats_menu.endurance_value.text = str(stats.endurance)


func _on_stats_pressed() -> void:
	_toggle_node_process_node(stats_menu, true)
	_toggle_node_process_node(moveset_menu, false)


func _on_moveset_pressed() -> void:
	_toggle_node_process_node(stats_menu, false)
	_toggle_node_process_node(moveset_menu, true)


func _toggle_node_process_node(node: Node, toggle_visible: bool):
	node.visible = toggle_visible
	if not node.visible:
		node.process_mode = PROCESS_MODE_DISABLED
	else:
		node.process_mode = PROCESS_MODE_INHERIT
