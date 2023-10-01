extends RigidBody3D

var is_in_hand = false
var hand
@export var interaction_text: String = "pick up radio equipment"


func _physics_process(delta):
	if is_in_hand:
		global_position = hand.global_position


# player picks up the plug to their hand
func pick_up(hand_object):
	print("I was picked up.")
	is_in_hand = true
	hand = hand_object
	freeze = true


func drop():
	is_in_hand = false
	freeze = false

# overriden in child
func get_interaction_text():
	return interaction_text

# overriden in child
func interact():
	print("interacted with ", name)
