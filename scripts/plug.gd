extends Attachable

signal plugged
signal un_plugged
#signal on_electricity_changed

@export var has_electricity = false
var is_plugged = false
var socket
var is_in_hand = false
var hand

# if the plug in a part of an extension cable, add every socket in that cable here
@export var own_sockets: Array[StaticBody3D]
# if the plug has an apparatus attached to it, add it here
@export var own_devices: Array[RigidBody3D]


func _ready():
	$has_electricity_visualiser.visible = is_energy_source
	# this way we can update every extension cable socket or devices on startup
	change_electricity(has_electricity)


func _physics_process(delta):
	if is_in_hand:
		global_position = hand.global_position
	if is_plugged:
		global_position = socket.global_position
		rotation = socket.global_rotation


# player picks up the plug to their hand
func pick_up(hand_object):
	if is_plugged:
		is_plugged = false
		socket.plug_unplugged(self)
		socket = null
	print("I was picked up.")
	freeze = true
	is_in_hand = true
	hand = hand_object


func drop():
	freeze = false
	is_in_hand = false


func plug_in(socket_object):
	is_in_hand = false
	socket = socket_object
	socket_object.plug_plugged(self)
	is_plugged = true
	global_position = socket_object.global_position
	rotation = socket_object.global_rotation


func change_electricity(value):
	# energy sources cannot be changed
	if !is_energy_source:
		has_electricity = value
		$has_electricity_visualiser.visible = value
		if own_sockets.size() != 0 and !own_sockets.has(socket):
			for socket in own_sockets:
				socket.change_electricity(value)
		if own_devices.size() != 0:
			for device in own_devices:
				device.change_electricity(value)


# this is used if instead of use key interaction the player is asked to move the socket into space manually
# ie distance based plugging
func _on_plug_detector_area_entered(area):
	if area.is_in_group("socket"):
		is_plugged = true
