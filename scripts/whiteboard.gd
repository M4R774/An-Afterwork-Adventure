extends Interactable

var interaction_text = "wipe the whiteboard"

var wiped_material = preload("res://textures/wiped_material.tres")
var interacted_at_least_once = false

func get_interaction_text():
	return interaction_text


func interact():
	get_tree().get_root().get_node("gameplay").player_made_progress(2)
	$AnimationPlayer.play("wipe")
