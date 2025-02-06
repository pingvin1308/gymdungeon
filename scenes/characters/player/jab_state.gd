extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var hit_component_collision_shape: CollisionShape2D
@export var attack_range: int = 20
@export var attack_trigger_range: float = 100.0

var player_height_offset: int = -15
var is_dashing: bool = false

func _ready() -> void:
	hit_component_collision_shape.set_deferred("disabled", true)
	hit_component_collision_shape.position = Vector2.ZERO


func _on_enter() -> void:
	if player.direction.y > 0.5:
		animated_sprite_2d.play("jab_down")
	elif player.direction.y < -0.5:
		animated_sprite_2d.play("jab_up")
	elif player.direction.x > 0.5:
		animated_sprite_2d.play("jab_right")
	elif player.direction.x < -0.5:
		animated_sprite_2d.play("jab_left")


func _on_dash_finished() -> void:
	is_dashing = false
	

func _on_next_transitions() -> void:
	if not animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_exit() -> void:
	animated_sprite_2d.stop()
	hit_component_collision_shape.set_deferred("disabled", true)
