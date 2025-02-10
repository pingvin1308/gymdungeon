class_name HealthBar
extends VBoxContainer

const HEALTH_PER_HEART = 4
const MAX_HEARTS_IN_ROW = 10
const MAX_POSSIBLE_HEALTH = 100
const HEART = preload("res://scenes/ui/heart.tscn")

@export var max_health_label: int:
	set(value):
		max_health_label = min(value, MAX_POSSIBLE_HEALTH)
		_update_heart_containers()

@export var current_health_label: int:
	set(value):
		current_health_label = clamp(value, 0, max_health_label)
		_update_health_display()

func _ready() -> void:
	_update_heart_containers()


func _update_heart_containers() -> void:
	var hearts_on_ui_count = ceil(max_health_label / float(HEALTH_PER_HEART))
	var hboxes_count = ceil(hearts_on_ui_count / float(MAX_HEARTS_IN_ROW))

	for child in get_children():
		remove_child(child)
		child.queue_free()

	for hbox_index in range(hboxes_count):
		var hbox := HBoxContainer.new()
		add_child(hbox)

		var hearts_in_row = min(hearts_on_ui_count - hbox_index * MAX_HEARTS_IN_ROW, MAX_HEARTS_IN_ROW)
		for _i in range(hearts_in_row):
			var heart_scene := HEART.instantiate() as Heart
			hbox.add_child(heart_scene)

	_update_health_display()


func _update_health_display() -> void:
	var max_hearts_count: int = ceil(max_health_label / float(HEALTH_PER_HEART))
	var current_hearts_count: int = ceil(current_health_label / float(HEALTH_PER_HEART))

	for heart_number in range(max_hearts_count):
		var row_index = heart_number / MAX_HEARTS_IN_ROW
		var col_index = heart_number % MAX_HEARTS_IN_ROW
		var quarters_in_heart = min((current_health_label - heart_number * 4), 4)
		quarters_in_heart = max(quarters_in_heart, 0)

		var row = get_child(row_index)
		if row:
			var heart = row.get_child(col_index)
			if heart:
				heart.set_value(quarters_in_heart)
