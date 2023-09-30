extends Interactable

@export var number = "0"

var interaction_text = "interact with keypad button"

signal on_interact

func set_number(value):
	number = value
	if value:
		$Viewport/Label.text = str(value)

func get_number():
	return number

func get_interaction_text():
	return interaction_text

func interact():
	emit_signal("on_interact", number)