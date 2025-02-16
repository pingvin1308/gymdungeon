class_name Player
extends CharacterBody2D

signal health_changed(max_health: int, current_health: int)
signal energy_changed(max_energy: int, current_energy: int)
signal stats_changed(stats: Stats)
signal attack_index_changed(attack_index: int)

@onready var progress_tracker: TrainingPlanProgressTracker = $TrainingPlanProgressTracker
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var energy_recovery_timer: Timer = $EnergyRecoveryTimer
@onready var hit_component_collision_shape: CollisionShape2D = $HitComponent/HitComponentCollisionShape2D
@onready var hit_component: HitComponent = $HitComponent

@export var attack_range: int = 20
@export var attack_trigger_range: float = 100.0
@export var stats: Stats

@export var attack_sequence: Array[SequenceItem] = []

@export var max_energy: int:
	set(value):
		max_energy = max(0, value)
		energy_changed.emit(max_energy, current_energy)

@export var current_energy: int:
	set(value):
		if current_energy != value:
			energy_changed.emit(max_energy, current_energy)

		current_energy = clamp(value, 0, max_energy)

@export var max_health: int:
	set(value):
		max_health = value
		health_changed.emit(max_health, current_health)

@export var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(max_health, current_health)

var attack_index: int:
	set (value):
		attack_index = clamp(value, 0, attack_sequence.size())
		attack_index_changed.emit(attack_index)

var combo_animations = []

var is_attack_sequence_finished: bool:
	get(): return not attack_index < attack_sequence.size()

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
	energy_changed.emit(max_energy, current_energy)
	stats.stats_changed.connect(func(): stats_changed.emit(stats))
	stats_changed.emit(stats)


func _on_hurt(attack: Attack, effects: Array[Effect]) -> void:
	#if is_invincible:
		#return
	attack.apply(self)

	current_health -= attack.damage
	progress_tracker.damage_consumed += attack.damage
	_apply_hurt_effect(attack.damage)
	if current_health <= 0:
		queue_free()
		return
	print("Player health: ", current_health)


func _on_timer_timeout() -> void:
	current_energy += 1


func _apply_hurt_effect(hit_damage: int) -> void:
	var hp_lost_fraction: float = float(hit_damage) / float(max_health)
	var recent_damage_taken = clamp(hp_lost_fraction, 0.0, 0.6)
	animated_sprite_2d.material.set_shader_parameter("damage", recent_damage_taken)
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.material.set_shader_parameter("damage", 0.0)


func _on_hit(damage: int) -> void:
	progress_tracker.damage_dealt += damage


func set_next_attack() -> void:
	if is_attack_sequence_finished:
		null

	var sequence_item = attack_sequence[attack_index]
	var effects: Array[Effect] = []

	while sequence_item is Effect:
		effects.push_back(sequence_item)
		attack_index += 1
		if is_attack_sequence_finished:
			break
		sequence_item = attack_sequence[attack_index]

	if sequence_item is Attack:
		attack_index += 1
		sequence_item.add_effects(effects)
		var result := Attack.new()
		result.name = sequence_item.name
		result.damage = sequence_item.damage
		result.added_effects = effects
		hit_component.attack = result



func reset_attack_sequence() -> void:
	attack_index = 0


#var is_invincible: bool = false
#func start_invincibility(duration: float):
	#is_invincible = true
	#var blink_timer = duration / 5.0  # Скорость мигания
	#for i in range(5):
		#visible = !visible  # Переключаем видимость
		#await get_tree().create_timer(blink_timer).timeout
	#visible = true
	#is_invincible = false


func _on_attack_sequence_attacks_list_changed(attacks_list: Array[SequenceItem]) -> void:
	attack_sequence = attacks_list
