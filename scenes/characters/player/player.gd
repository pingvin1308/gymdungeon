class_name Player
extends CharacterBody2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var hit_component_collision_shape: CollisionShape2D = $HitComponent/HitComponentCollisionShape2D

@export var health: int = 30
@export var energy: int = 100
@export var attack_range: int = 20
@export var attack_trigger_range: float = 100.0


var current_health: int
var direction: Vector2 = Vector2.ZERO
var lerp_speed: float = 10.0
var lerp_velocity_value_on_floor: float = 16

const PLAYER_HEIGHT_OFFSET: int = -15
const SPEED: int = 100

var is_attacking: bool = false


func _ready() -> void:
	current_health = health
	hurt_component.hurt.connect(_on_hurt)
	timer.timeout.connect(_on_timer_timeout)


func _on_hurt(hit_damage: int) -> void:
	health -= hit_damage
	_apply_hurt_effect(hit_damage)
	if health <= 0:
		queue_free()
		return
	print("Player health: ", health)


func _on_timer_timeout() -> void:
	energy = clamp(energy + 1, 0, 100)


func _apply_hurt_effect(hit_damage: int) -> void:
	var hp_lost_fraction: float = float(hit_damage) / float(health)
	var recent_damage_taken = clamp(hp_lost_fraction, 0.0, 0.6)
	animated_sprite_2d.material.set_shader_parameter("damage", recent_damage_taken)
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.material.set_shader_parameter("damage", 0.0)
