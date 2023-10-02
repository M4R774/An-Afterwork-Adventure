extends Interactable

var interaction_text = "pick up keycard"
var keyboard_flipped = false
var interacted_at_least_once = false

func get_interaction_text():
	return interaction_text


func interact():
	get_tree().get_root().get_node("gameplay").player_made_progress(6)
	var player_inventory = get_tree().root.get_node("gameplay/Player/Inventory")
	player_inventory.add_item_to_inventory(player_inventory.items.keycard)
	queue_free()
