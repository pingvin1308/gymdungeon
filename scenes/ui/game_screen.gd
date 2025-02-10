extends CanvasLayer

@export var health_bar: HealthBar


func _on_player_health_changed(max_health: int, current_health: int) -> void:
	health_bar.max_health_label = max_health
	health_bar.current_health_label = current_health
