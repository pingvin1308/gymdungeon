extends Node


var inventory: Dictionary = {}


func add_item(item_name: String, amount: int) -> void:
    if inventory.has(item_name):
        inventory[item_name] += amount
    else:
        inventory[item_name] = amount

    print(inventory)

    
func remove_item(item_name: String, amount: int) -> void:
    if inventory.has(item_name):
        inventory[item_name] -= amount
        if inventory[item_name] <= 0:
            inventory.erase(item_name)
