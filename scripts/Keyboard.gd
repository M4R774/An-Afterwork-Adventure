extends Interactable

var interaction_text = "flip keyboard"
var keyboard_flipped = false

@onready var animation_player = $AnimationPlayer

func get_interaction_text():
	return interaction_text

func interact():
	get_tree().get_root().get_node("gameplay").player_made_progress(0)

	keyboard_flipped = !keyboard_flipped
	if keyboard_flipped:
		animation_player.play("keyboard_flip")
	else:
		animation_player.play_backwards("keyboard_flip")

