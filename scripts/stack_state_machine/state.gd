class_name State
extends Node

const PREVIOUS_STATE: String = &"previous"

@warning_ignore("unused_signal")
signal finished(next_state_name: NodePath)

var _name: String:
	get():
		return name.to_lower()


func _enter() -> void:
	pass


func _exit() -> void:
	pass


func _update(_delta: float) -> void:
	pass


func _on_animation_finished(animation_name: String) -> void:
	pass


func _handle_input(_event: InputEvent) -> void:
	pass
