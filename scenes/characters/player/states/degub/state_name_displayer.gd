extends Label

var start_position = Vector2()

@export var character_body: CharacterBody2D


func _ready():
	start_position = position


func _physics_process(_delta):
	global_position = character_body.global_position + start_position


func _on_state_machine_state_changed(current_state):
	text = String(current_state.get_name())
