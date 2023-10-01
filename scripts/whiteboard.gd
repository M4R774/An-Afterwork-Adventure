extends Interactable

var interaction_text = "interact with whiteboard"

var wiped_material = preload("res://textures/wiped_material.tres")


func get_interaction_text():
	return interaction_text


func interact():
	$whiteboard/whiteboard2.set_surface_override_material(0, wiped_material)
	self.collision_layer = 1
