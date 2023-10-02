extends StaticBody3D

@export var door: Interactable = null
@export var interaction_text: String = "read keycard"


func _ready():
	if door == null:
		print("ERROR! Door is not set for keycard reader!")

func get_interaction_text():
	var player_inventory = get_tree().root.get_node("gameplay/Player/Inventory")
	if player_inventory.check_if_item_is_in_inventory(player_inventory.items.keycard):
		return "insert keycard"
	else:
		return ""

func interact():
	var player_inventory = get_tree().root.get_node("gameplay/Player/Inventory")
	if player_inventory.check_if_item_is_in_inventory(player_inventory.items.keycard):
		door.open()
