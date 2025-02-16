class_name HurtComponent
extends Area2D

signal hurt(attack: Attack, effects: Array[Effect])


func _on_area_entered(area: Area2D) -> void:
	if area is HitComponent:
		if area.attack:
			print(area.attack.name)
			hurt.emit(area.attack, area.effects)
		else:
			var attack = Attack.new()
			attack.damage = 1
			attack.name = "jab"

			hurt.emit(attack, [] as Array[Effect])
