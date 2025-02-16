class_name Heart
extends Control

@export var heart_states: Array[TextureRect] = []

enum {
	EMPTY_HEART,
	LAST_QUARTER_HEART,
	TREE_QUARTERS_HEART,
	HALF_HEART,
	FULL_HEART,
 }

var max_value: int = 4
var current_value: int = max_value


func _ready() -> void:
	set_value(max_value)
	#update_state()


#func increase() -> void:
	#current_value = clamp(current_value + 1, 0, max_value)
	#update_state()
#
#
#func decrease() -> void:
	#current_value = clamp(current_value - 1, 0, max_value)
	#update_state()


func set_value(quarters_in_heart: int) -> void:
	for i in max_value+1:
		if i == quarters_in_heart:
			heart_states[i].visible = true
		else:
			heart_states[i].visible = false

	#var quarter_health = min(current_value, max_value) * 4 / max_health # Кол-во четвертей от max_health
	#var full_quarters = int(quarter_health) # Округляем вниз

	#for i in range(hearts.size()):
		#var quarters_in_heart = min(full_quarters - i * 4, 4) # Сколько четвертей у текущего сердца
		#quarters_in_heart = max(quarters_in_heart, 0) # Не даем уйти в отрицательные значения
		#hearts[i].texture = heart_textures[quarters_in_heart]
