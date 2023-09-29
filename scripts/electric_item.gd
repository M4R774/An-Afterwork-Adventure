extends RigidBody3D

@export_flags ("plug", "socket", "water") var type: int = 0

@export var is_energy_source : bool
@export var has_electricity : bool
var is_plugged = false
var is_conducting = false # touching water
var socket = null
var plug = null
var is_in_hand = false
var hand

# if the plug in a part of an extension cable, add every socket in that cable here
# or if the socket is an input one, it needs outputs
@export var own_sockets: Array[RigidBody3D]
# if the plug has an apparatus attached to it eg. a radio, add it here
@export var own_devices: Array[RigidBody3D]


func _ready():
	if is_energy_source:
		has_electricity = true
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
	print("I was picked up.")
	if socket != null:
		socket.plug_unplugged(self)
		socket = null
	if is_conducting:
		change_electricity(false)
		is_conducting = false
	if is_plugged:
		is_plugged = false
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
	if socket_object.is_in_group("water"):
		is_conducting = true
	elif socket_object.type != type:
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
		#if plug != null:
			#plug.has_electricity = value


func can_plug_in(incoming_item):
	var can = false
	if plug == null and incoming_item.type != type:
		can = true
	return can


func plug_plugged(attached_plug):
	plug = attached_plug
	if self.is_in_group("water"):
		# if the water is not electrified and the plug carries electricity
		if plug.has_electricity and !has_electricity:
			change_electricity(true)
	else:
		if own_sockets.size() == 0: # ie this socket is not an input one
			plug.change_electricity(has_electricity)
		else: # the socket is an input
			change_electricity(plug.has_electricity)


func plug_unplugged(detached_plug):
	if self.is_in_group("water"):
		pass
	else:
		if own_sockets.size() == 0: # ie this socket is not an input one
			plug.change_electricity(false)
		else: # the socket is an input
			change_electricity(false) 
	plug = null


# Water monitors if something enters its area
func _on_area_3d_body_entered(body):
	print(body.name, " entered ", self.name)
	print(body.get_groups())
	if body.type != type:
		body.plug_in(self)
		# if the water puddle has electricity and the incoming item doesn't, give the item electricity
		if !body.has_electricity and has_electricity:
			body.change_electricity(true)
		if body.has_electricity:
			change_electricity(true)
			for item in own_sockets:
				item.has_electricity = has_electricity
		own_sockets.append(body)


func _on_area_3d_body_exited(body):
	if body.type != type:
		own_sockets.erase(body)
		if body.is_energy_source:
			change_electricity(false)
