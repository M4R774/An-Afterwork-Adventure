extends Node3D

class_name radio

@export var radio_transmitter: radio_transmitter
var has_power: bool = false

func _ready():
	if radio_transmitter == null:
		print("Error: Radio transmitter not set!")

func _on_plug_electricity_changed(value):
	has_power = value
	if has_power:
		if radio_transmitter.has_power:
			$morse.start()
			$kohina.stop()
		else:
			$morse.stop()
			$kohina.start()
	else:
		$kohina.stop()
		$morse.stop()

func radio_transmission_started():
	_on_plug_electricity_changed(has_power)
