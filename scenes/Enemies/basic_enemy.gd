class_name BasicEnemy
extends CharacterBody2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var chase_component: ChaseComponent = $ChaseComponent

@export var health: int = 3
# @export var chase_range: int = 200

@export var attack_range: int = 100
@export var attack_damage: int = 1
@export var attack_cooldown: float = 1.0
@export var speed = 40

var target_player: Player
var is_chasing: bool


func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	chase_component.start_chasing.connect(on_start_chasing)
	chase_component.stop_chasing.connect(on_stop_chasing)


func on_hurt(hit_damage: int) -> void:
	health -= hit_damage
	if health <= 0:
		queue_free()
		return


func on_start_chasing(player: Player) -> void:
	target_player = player
	is_chasing = true


func on_stop_chasing() -> void:
	target_player = null
	is_chasing = false