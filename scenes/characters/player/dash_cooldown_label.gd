extends Label

var start_position = Vector2()

@export var character_body: CharacterBody2D
@export var cooldown_timer: Timer


func _ready():
	start_position = position


func _physics_process(_delta):
	global_position = character_body.global_position + start_position
	text = "%.2f" % cooldown_timer.time_left
