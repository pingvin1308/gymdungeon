class_name Player
extends CharacterBody2D

signal health_changed(max_health: int, current_health: int)
signal energy_changed(max_energy: int, current_energy: int)
signal stats_changed(stats: Stats)

@onready var progress_tracker: TrainingPlanProgressTracker = $TrainingPlanProgressTracker
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var energy_recovery_timer: Timer = $EnergyRecoveryTimer
@onready var hit_component_collision_shape: CollisionShape2D = $HitComponent/HitComponentCollisionShape2D

@export var attack_range: int = 20
@export var attack_trigger_range: float = 100.0
@export var stats: Stats

@export var max_energy: int:
	set(value):
		max_energy = max(0, value)
		energy_changed.emit(max_energy, current_energy)

@export var current_energy: int:
	set(value):
		current_energy = clamp(value, 0, max_energy)
		energy_changed.emit(max_energy, current_energy)

@export var max_health: int:
	set(value):
		max_health = value
		health_changed.emit(max_health, current_health)

@export var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(max_health, current_health)

var direction: Vector2 = Vector2.ZERO
var lerp_speed: float = 10.0
var lerp_velocity_value_on_floor: float = 16
var is_attacking: bool = false

const PLAYER_HEIGHT_OFFSET: int = -15
const SPEED: int = 100


func _ready() -> void:
	current_health = max_health
	hurt_component.hurt.connect(_on_hurt)
	energy_recovery_timer.timeout.connect(_on_timer_timeout)
	health_changed.emit(max_health, current_health)
	stats.stats_changed.connect(func(): stats_changed.emit(stats))
	stats_changed.emit(stats)


func _on_hurt(hit_damage: int) -> void:
	current_health -= hit_damage
	progress_tracker.damage_consumed += hit_damage
	_apply_hurt_effect(hit_damage)
	if current_health <= 0:
		queue_free()
		return
	print("Player health: ", current_health)


func _on_timer_timeout() -> void:
	current_energy = clamp(current_energy + 1, 0, max_energy)


func _apply_hurt_effect(hit_damage: int) -> void:
	var hp_lost_fraction: float = float(hit_damage) / float(max_health)
	var recent_damage_taken = clamp(hp_lost_fraction, 0.0, 0.6)
	animated_sprite_2d.material.set_shader_parameter("damage", recent_damage_taken)
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.material.set_shader_parameter("damage", 0.0)


func _on_hit(damage: int) -> void:
	progress_tracker.damage_dealt += damage
