extends NodeState

@onready var cooldown_timer: Timer = $CooldownTimer

@export var player: Player
@export var strength: int = 250 

var velocity: Vector2 = Vector2.ZERO
var duration: float = 0.0
var direction: Vector2
var cooldown: float = 0.5
var can_use_dash: bool = true


func _ready() -> void:
	cooldown_timer.timeout.connect(on_timeout)


func _on_enter() -> void:
	if player == null:
		return

	if not can_use_dash:
		return

	if duration <= 0:
		velocity = player.direction * strength
		duration = 0.1
		can_use_dash = false
		cooldown_timer.start(cooldown)


func _on_physics_process(_delta: float) -> void:
	if duration > 0:
		duration -= _delta
		player.velocity = velocity
		player.move_and_slide()


func _on_next_transitions() -> void:
	if duration <= 0:
		transition.emit("Idle")


func on_timeout() -> void:
	can_use_dash = true
	pass
