extends Interactable

var interaction_text = "wipe the whiteboard"

var wiped_material = preload("res://textures/wiped_material.tres")


func get_interaction_text():
	return interaction_text


func interact():
	$AnimationPlayer.play("wipe")
