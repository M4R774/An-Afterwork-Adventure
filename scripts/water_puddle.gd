extends Node3D

@export_flags ("plug", "socket", "water") var type: int = 0
@export var is_energy_source : bool
@export var own_sockets: Array[RigidBody3D]
@export var own_devices: Array[RigidBody3D]
var has_electricity : bool = false
var socket = null


func change_electricity(value):
	# energy sources cannot be changed
	print("changing electricity")
	if !is_energy_source:
		has_electricity = value
		$has_electricity_visualiser.visible = value
		if own_sockets.size() != 0 and !own_sockets.has(socket):
			for socket in own_sockets:
				socket.change_electricity(value)
		if own_devices.size() != 0:
			for device in own_devices:
				device.change_electricity(value)


func _on_area_3d_body_entered(body):
	print("something entered")
	if body.type != type:
		body.plug_in(self)
		if body.has_electricity:
			change_electricity(true)
			for item in own_sockets:
				item.has_electricity = has_electricity
			print("i'm deadly water now")
		else:
			print("water remains safe")
		own_sockets.append(body)


func _on_area_3d_body_exited(body):
	if body.type != type:
		own_sockets.erase(body)
		if body.is_energy_source:
			change_electricity(false)
