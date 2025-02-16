class_name AttackSequence
extends Control

signal attacks_list_changed(attacks_list: Array[SequenceItem])

var sequence_item_scene = preload("res://scenes/ui/combat/sequence_item_container.tscn")

@export var attacks_list_container: HBoxContainer
@export var attacks_select_panel: AttacksSelectPanel
@export var timer: Timer
@export var attacks_list: Array[SequenceItem]

var stack: Array[int] = []

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

	var default_sequence := [
		SequenceItemResourceManager.get_resource(&"jab"),
		SequenceItemResourceManager.get_resource(&"knockback"),
		SequenceItemResourceManager.get_resource(&"jab")
	]

	for sequence_item in default_sequence:
		if sequence_item:
			attacks_list.push_back(sequence_item)

	attacks_list_changed.emit(attacks_list)

	for i in range(attacks_list.size()):
		var attack_item = attacks_list[i]
		var item = sequence_item_scene.instantiate() as SequenceItemContainer
		item.index = i
		item.sequence_item_selected.connect(_open_sequence_list)
		attacks_list_container.add_child(item)
		item.sequence_item = attack_item

	var all_resources = SequenceItemResourceManager.get_all_resources()
	for i in range(all_resources.size()):
		var attack_item = all_resources[i]
		var item = sequence_item_scene.instantiate() as SequenceItemContainer
		item.index = i
		item.sequence_item_selected.connect(_on_sequence_item_selected)
		attacks_select_panel.add_sequence_item(item)
		item.sequence_item = attack_item

var index_sequence_item_to_change: int

func _open_sequence_list(index: int) -> void:
	index_sequence_item_to_change = index
	attacks_select_panel.visible = true


#func _on_gui_input(event: InputEvent) -> void:
	#if event.is_action_pressed("hit"):
		#attacks_select_panel.visible = !attacks_select_panel.visible


func _on_sequence_item_selected(index: int) -> void:
	var sequence_item = attacks_select_panel.get_sequence_item(index)
	var container = attacks_list_container.get_child(index_sequence_item_to_change) as SequenceItemContainer
	container.sequence_item = SequenceItemResourceManager.get_resource(sequence_item.name)
	attacks_select_panel.visible = false
	attacks_list[index_sequence_item_to_change] = sequence_item

func change_attack_list() -> void:
	attacks_list_changed.emit(attacks_list)
	pass


func update_attack_index(attack_index: int) -> void:
	stack.push_back(attack_index)
	print(stack)

func _on_timeout() -> void:
	if stack.is_empty():
		return

	var attack_index = stack.pop_front()
	var children = attacks_list_container.get_children()
	var previous_attack_index = attack_index - 1

	for i in range(children.size()):
		var child = children[i]
		if i == attack_index:
			child.enable()
		else:
			child.disable()
