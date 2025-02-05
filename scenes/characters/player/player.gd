class_name Player
extends CharacterBody2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

@export var health: int = 30
@export var energy: int = 100

var current_health: int
var direction: Vector2


func _ready() -> void:
	current_health = health
	hurt_component.hurt.connect(on_hurt)
	timer.timeout.connect(_on_timer_timeout)


func on_hurt(hit_damage: int) -> void:
	health -= hit_damage
	apply_hurt_effect(hit_damage, health)
	if health <= 0:
		queue_free()
		return
	print("Player health: ", health)


func _on_timer_timeout() -> void:
	energy = clamp(energy + 1, 0, 100)
	timer.start()


func apply_hurt_effect(hit_damage: int, health: int) -> void:
	var hp_lost_fraction: float = float(hit_damage) / float(health)
	var recent_damage_taken = clamp(hp_lost_fraction, 0.0, 0.6)
	animated_sprite_2d.material.set_shader_parameter("damage", recent_damage_taken)
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.material.set_shader_parameter("damage", 0.0)