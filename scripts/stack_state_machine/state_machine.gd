class_name StateMachine
extends Node

signal state_changed(current_state: String)

@export var start_state: State

const PREVIOUS_STATE: String = &"previous"

var states_map: Dictionary = {}
var states_stack: Array[State] = []
var current_state: State
var _active: bool = false:
	set(value):
		_active = value
		_set_active(value)


func _enter_tree() -> void:
	for child in get_children():
		var err = child.finished.connect(_change_state)
		if err:
			printerr(err)
	initialize(start_state)


func initialize(initial_state: State) -> void:
	_active = true
	states_stack.push_front(initial_state)
	current_state = states_stack[0]
	current_state._enter()


func _set_active(value: bool):
	set_physics_process(value)
	set_process(value)
	if not _active:
		states_stack = []
		current_state = null


func _unhandled_input(event: InputEvent) -> void:
	current_state._handle_input(event)


func _physics_process(delta: float) -> void:
	current_state._update(delta)


func _on_animation_finished(animation_name: String) -> void:
	if not _active:
		return
	current_state._on_animation_finished(animation_name)


func _change_state(state_name: String) -> void:
	if not _active:
		return

	current_state._exit()

	if state_name == PREVIOUS_STATE:
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]

	current_state = states_stack[0]
	state_changed.emit(current_state)

	if state_name != PREVIOUS_STATE:
		current_state._enter()
