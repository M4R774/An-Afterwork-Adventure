extends Interactable

class_name radio

@export var radio_transmitter: radio_transmitter
var has_power: bool = false

var is_in_hand = false
var hand

func _ready():
	if radio_transmitter == null:
		print("Error: Radio transmitter not set!")

func _physics_process(delta):
	if is_in_hand:
		global_position = hand.global_position


func _on_plug_electricity_changed(value):
	print("Radio sai virtaa:")
	print(value)
	has_power = value
	if has_power:
		if radio_transmitter.has_power:
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

# overriden in child
func get_interaction_text():
	return "pick up radio"

# overriden in child
func interact():
	print("interacted with ", name)
