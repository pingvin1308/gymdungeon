class_name BasicEnemy
extends CharacterBody2D

var protein = preload("res://scenes/collectibles/protein/protein.tscn")

signal knockback()

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var chase_component: ChaseComponent = $ChaseComponent
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var health: int = 15
@export var attack_range: int = 60
@export var attack_damage: int = 1
@export var attack_cooldown: float = 1.0
@export var speed = 20

var current_health: int
var target_player: Player
var is_chasing: bool


func _ready() -> void:
	current_health = health
	hurt_component.hurt.connect(on_hurt)
	chase_component.start_chasing.connect(on_start_chasing)
	chase_component.stop_chasing.connect(on_stop_chasing)


func on_hurt(attack: Attack, effects: Array[Effect]) -> void:
	health -= attack.damage

	attack.apply(self)

	apply_hurt_effect(attack.damage, health)
	if health <= 0:
		var protein_instance = protein.instantiate() as Node2D
		protein_instance.global_position = global_position
		get_parent().add_child(protein_instance)
		queue_free()
		return

	print("Enemy health: ", health)


func apply_hurt_effect(hit_damage: int, health: int) -> void:
	var hp_lost_fraction : float = float(hit_damage) / float(health)
	var recent_damage_taken = clamp(hp_lost_fraction, 0.0, 0.6)
	animated_sprite_2d.material.set_shader_parameter("damage", recent_damage_taken)
	await get_tree().create_timer(0.2).timeout
	animated_sprite_2d.material.set_shader_parameter("damage", 0.0)


func on_start_chasing(player: Player) -> void:
	target_player = player
	is_chasing = true


func on_stop_chasing() -> void:
	target_player = null
	is_chasing = false
