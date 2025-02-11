extends Control

@onready var moves_list: HBoxContainer = $MovesList
@onready var move_select_panel: Panel = $MoveSelectPanel


func _ready() -> void:
	for child in moves_list.get_children():
		var control = child as Control
		if control:
			control.gui_input.connect(_on_gui_input)


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("hit"):
		move_select_panel.visible = !move_select_panel.visible
