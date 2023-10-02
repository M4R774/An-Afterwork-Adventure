extends Interactable

class_name radio

@export var radio_transmitter: radio_transmitter
var has_power: bool = false
var interacted_at_least_once = false

func _ready():
	if radio_transmitter == null:
		print("Error: Radio transmitter not set!")


func _on_plug_electricity_changed(value):
	has_power = value
	if has_power:
		if radio_transmitter.has_power:
			get_tree().get_root().get_node("gameplay").player_made_progress(4)
			$morse.play()
			$kohina.stop()
		else:
			$morse.stop()
			$kohina.play()
	else:
		$kohina.stop()
		$morse.stop()

func radio_transmission_started():
	_on_plug_electricity_changed(has_power)

