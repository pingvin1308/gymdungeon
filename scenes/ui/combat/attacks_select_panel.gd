class_name AttacksSelectPanel
extends PanelContainer

@export var sequence_items_to_select: GridContainer


func add_sequence_item(sequence_item: SequenceItemContainer) -> void:
	sequence_items_to_select.add_child(sequence_item)


func get_sequence_item(index: int) -> SequenceItem:
	var container = sequence_items_to_select.get_child(index)
	if container and container is SequenceItemContainer:
		return (container as SequenceItemContainer).sequence_item

	return null


#func remove_sequence_item(index: int) -> void:
	#var container = sequence_items_to_select.get_child(index)
	#if container:
		#sequence_items_to_select.remove_child(container)
		#container.queue_free()
