extends PlayerState

@export var hit_component_collision_shape: CollisionShape2D
@export var attack_range: int = 20
@export var attack_trigger_range: float = 100.0

const MAX_COMBO_COUNT = 3

enum AttackInputStates { IDLE, LISTENING, REGISTERED }
enum States { IDLE, ATTACK }

var attack_animations: Dictionary = {
	"jab_left": 0, "jab_right":0, "jab_up":0, "jab_down":0
}
var state = null
var is_attacking: bool = false
var attack_input_state = AttackInputStates.IDLE
var ready_for_next_attack = false
var combo_count = 0
var combo_animations = []


func _ready() -> void:
	animation_player.animation_finished.connect(_on_attack_finished)
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO
	_change_state(States.IDLE)


func _enter() -> void:
	_change_state(States.IDLE)
	attack()


func _change_state(new_state):
	match state:
		States.ATTACK:
			attack_input_state = AttackInputStates.LISTENING
			ready_for_next_attack = false

	match new_state:
		States.IDLE:
			combo_count = 0
			animation_player.stop()
			hit_component_collision_shape.set_deferred("disabled", true)
			hit_component_collision_shape.position = Vector2.ZERO
		States.ATTACK:
			var mouse_position = get_viewport().get_mouse_position()
			var attack_direction = (mouse_position - player.global_position).normalized()
			hit_component_collision_shape.position = attack_direction * attack_range
			hit_component_collision_shape.set_deferred("disabled", false)
			var animation_name = _get_animation_name(attack_direction);
			animation_player.play(animation_name)
	state = new_state


func _physics_process(_delta):
	if attack_input_state == AttackInputStates.REGISTERED and ready_for_next_attack:
		attack()


func attack():
	combo_count = clamp(combo_count + 1, 0, MAX_COMBO_COUNT)
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO
	_change_state(States.ATTACK)


func _exit() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO


func _on_attack_finished(animation_name: StringName):
	if not attack_animations.has(animation_name):
		return

	ready_for_next_attack = true

	if attack_input_state == AttackInputStates.REGISTERED and combo_count < MAX_COMBO_COUNT:
		attack()
	else:
		_change_state(States.IDLE)
		finished.emit(PREVIOUS_STATE)


func _unhandled_input(event):
	if not state == States.ATTACK:
		return
	if attack_input_state != AttackInputStates.LISTENING:
		return
	if event.is_action_pressed("hit"):
		attack_input_state = AttackInputStates.REGISTERED


func _get_animation_name(attack_direction: Vector2) -> String:
	if attack_direction.y > 0.5 and attack_direction.x > 0.5:
		return "jab_right"
	elif attack_direction.y < 0.5 and attack_direction.x > 0.5:
		return "jab_right"
	elif attack_direction.x > 0.5:
		return "jab_right"
	elif attack_direction.y > -0.5 and attack_direction.x < -0.5:
		return "jab_left"
	elif attack_direction.y < -0.5 and attack_direction.x < -0.5:
		return "jab_left"
	elif attack_direction.x < -0.5:
		return "jab_left"
	elif attack_direction.y > 0.5:
		return "jab_down"
	elif attack_direction.y < -0.5:
		return "jab_up"
	return ""
