class_name Spawner
extends Node

@onready var enemy_scene = preload("res://scenes/characters/enemies/basic_enemy.tscn")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("spawn"):
		var enemy = enemy_scene.instantiate() as Node2D
		get_parent().add_child(enemy)
		var player = get_tree().get_nodes_in_group("player")[0] as Node2D
		enemy.global_position = player.global_position
