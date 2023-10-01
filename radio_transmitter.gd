extends Interactable

class_name radio_transmitter

@export var radio_receiver: radio = null
var has_power: bool = false
@onready var extension = $plug_with_cable/extension

func _ready():
	if radio_receiver == null:
		print("Error: Radio receiver not set!")

func _on_plug_electricity_changed(value):
	has_power = value
	radio_receiver.radio_transmission_started()

# overriden in child
func get_interaction_text():
	return "pick up transmitter"

# overriden in child
func interact():
	print("interacted with ", name)
