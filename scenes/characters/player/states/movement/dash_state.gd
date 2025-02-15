extends MovementState

@onready var cooldown_timer: Timer = $CooldownTimer
@export var strength: int = 250
@export var energy_cost: int = 1
@export var dash_duration: float = 0.2

var velocity: Vector2 = Vector2.ZERO
var duration: float = 0.0
var direction: Vector2
var cooldown: float = 0.5
var can_use_dash: bool = true
@export var invincibility_duration: float = 0.05  # Время неуязвимости (можно чуть больше, чем дэш)


func _ready() -> void:
	cooldown_timer.timeout.connect(on_timeout)


func _enter() -> void:
	if player == null:
		return

	if not can_use_dash:
		return

	if player.current_energy <= energy_cost:
		return

	if duration <= 0:
		velocity = player.direction * strength
		duration = dash_duration
		can_use_dash = false
		player.current_energy -= energy_cost
		#player.is_invincible = true
		#player.start_invincibility(invincibility_duration)
		cooldown_timer.start(cooldown)


func _update(_delta: float) -> void:
	if duration > 0:
		duration -= _delta
		player.velocity = velocity
		player.move_and_slide()
	else:
		finished.emit(PREVIOUS_STATE)


func on_timeout() -> void:
	can_use_dash = true
	pass
