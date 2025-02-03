class_name Player
extends CharacterBody2D

@onready var hurt_component: HurtComponent = $HurtComponent

@export var health: int = 3

var player_direction: Vector2


func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)


func on_hurt(hit_damage: int) -> void:
	# health -= hit_damage
	if health <= 0:
		queue_free()
		return
	print("Player health: ", health)