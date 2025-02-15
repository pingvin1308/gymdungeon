class_name AttackSequence
extends Control

@export var attacks_list_container: HBoxContainer
@export var attacks_select_panel: PanelContainer

var attacks_list: Array[SequenceItem]


func change_attack_list() -> void:
	pass


func _ready() -> void:
	for child in attacks_list_container.get_children():
		var control = child as Control
		if control:
			control.gui_input.connect(_on_gui_input)


func _update_list() -> void:
	for attack in attacks_list:
		pass


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("hit"):
		attacks_select_panel.visible = !attacks_select_panel.visible


func _on_player_attack_index_changed(attack_index: int) -> void:
	var children = attacks_list_container.get_children()
	for i in range(children.size()):
		var child = children[i]
		if i == attack_index:
			child.enable()
		else:
			child.disable()
