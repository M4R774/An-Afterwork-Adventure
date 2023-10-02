extends Node


enum items {keycard, key}

var player_inventroy = []

func _ready():
	player_inventroy.clear()

func add_item_to_inventory(item):
	if !player_inventroy.has(item):
		player_inventroy.append(item)

func check_if_item_is_in_inventory(item):
	print(player_inventroy)
	print(item)
	print(player_inventroy.has(item))
	return player_inventroy.has(item)
