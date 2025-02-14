class_name EnemyStateMachine
extends StateMachine

@onready var idle: Node = $Idle
@onready var knockback: Node = $Knockback
@onready var chase: Node = $Chase
@onready var attack: Node = $Attack


func _ready() -> void:
	states_map = {
		"idle": idle,
		"attack": attack,
		"chase": chase,
		"knockback": knockback
	}


func _change_state(state_name: String) -> void:
	super._change_state(state_name)


func _on_start_chasing(_player: Node2D) -> void:
	_change_state("chase")

func _on_stop_chasing() -> void:
	_change_state("idle")

var hurt_sequence: int = 0

func _on_hurt(_attack: Attack) -> void:
	if hurt_sequence == 1:
		_change_state("knockback")
		hurt_sequence = 0
	else:
		hurt_sequence += 1
