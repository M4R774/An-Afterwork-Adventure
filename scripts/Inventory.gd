extends Node


enum items {keycard, key}

var player_inventroy = []


func _ready():
	add_item_to_inventory(items.keycard)

func add_item_to_inventory(item):
	if !player_inventroy.has(item):
		player_inventroy.append(item)
