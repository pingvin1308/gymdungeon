class_name Protein
extends Sprite2D

const NAME: String = "protein"


func _on_collect(body:Node2D) -> void:
    if body is Player:
        InventoryManager.add_item(NAME, 1)
        queue_free()
