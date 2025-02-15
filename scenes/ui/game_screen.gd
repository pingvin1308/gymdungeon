extends CanvasLayer

@export var health_bar: HealthBar
@export var energy_bar: EnergyBar
@export var debug: Control
@export var notebook: Notebook
#@export var


func _ready() -> void:
	_toggle_node_process_node(debug, false)
	_toggle_node_process_node(notebook, false)


func _on_player_health_changed(max_health: int, current_health: int) -> void:
	health_bar.max_health_label = max_health
	health_bar.current_health_label = current_health


func _on_player_energy_changed(max_energy: int, current_energy: int) -> void:
	energy_bar.max_energy_label = max_energy
	energy_bar.current_energy_label = current_energy


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("stas"):
		_toggle_node_process_node(debug, not debug.visible)
	elif event.is_action_pressed("notebook"):
		_toggle_node_process_node(notebook, not notebook.visible)


func _toggle_node_process_node(node: Node, toggle_visible: bool):
	node.visible = toggle_visible
	if not node.visible:
		node.process_mode = PROCESS_MODE_DISABLED
	else:
		node.process_mode = PROCESS_MODE_INHERIT
