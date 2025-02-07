extends StateMachine

@onready var idle: Node = $Idle
@onready var move: Node = $Move
@onready var dash: Node = $Dash
@onready var attack: Node = $Attack


func _ready() -> void:
	states_map = {
		"idle": idle,
		"move": move,
		"attack": attack,
		"dash": dash
	}

func _change_state(state_name: String) -> void:
	if not _active:
		return

	if state_name in ["attack", "dash"]:
		states_stack.push_front(states_map[state_name])

	super._change_state(state_name)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("hit"):
		if current_state in [attack]:
			return
		_change_state("attack")
		return

	current_state._handle_input(event)
