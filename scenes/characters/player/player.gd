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


func _ready() -> void:
	current_health = health
	hurt_component.hurt.connect(on_hurt)
	timer.timeout.connect(_on_timer_timeout)
	hit_component_collision_shape.disabled
	#set_deferred("disabled", true)


func _physics_process(delta: float) -> void:
	_move(delta)
	if Input.is_action_just_pressed("hit"):
		_attack()
	else:
		hit_component_collision_shape.set_deferred("disabled", true)
		hit_component_collision_shape.position = Vector2.ZERO


func _attack() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var attack_direction = (mouse_position - global_position).normalized()
	hit_component_collision_shape.position = attack_direction * attack_range + Vector2(0, PLAYER_HEIGHT_OFFSET)
	hit_component_collision_shape.set_deferred("disabled", false)


func _move(delta: float) -> void:
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")

	direction = lerp(direction, Vector2(input_dir.x, input_dir.y).normalized(), delta * lerp_speed)

	var move_x = direction.x * SPEED
	var move_y = direction.y * SPEED
	if direction: 
		velocity.x = move_x 
		velocity.y = move_y
	else: 
		velocity.x = lerp(velocity.x, move_x, delta * lerp_velocity_value_on_floor) 
		velocity.y = lerp(velocity.y, move_y, delta * lerp_velocity_value_on_floor)
		
	move_and_slide()


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
