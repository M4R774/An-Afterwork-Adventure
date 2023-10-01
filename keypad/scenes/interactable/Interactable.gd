extends Node3D

class_name Interactable

# overriden in child
func get_interaction_text():
	return "interaction text here"

# overriden in child
func interact():
	print("interacted with ", name)
