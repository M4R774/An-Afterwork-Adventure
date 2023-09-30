extends Interactable

var interaction_text = "interact with keyboard"
var keyboard_flipped = false

@onready var animation_player = $AnimationPlayer

func get_interaction_text():
	return interaction_text

func interact():
	keyboard_flipped = !keyboard_flipped
	if keyboard_flipped:
		animation_player.play("keyboard_flip")
	else:
		animation_player.play_backwards("keyboard_flip")

