extends Attachable

# Sockets can be either inputs (they can take a plug that carries electricity)
# or an output (they can take a plug and give that plug electricity)

signal plugged
signal unplugged

var has_electricity = false
var my_plug = null

# NOT IMPLEMENTED, SEEMS UNUSEFUL
# if this socket is connected to a plug via cable, the plug updates itself on ready here
# var connected_plug = null

# If this socket is an input, it should have an output too
@export var my_outputs: Array[StaticBody3D]

func _ready():
	has_electricity = is_energy_source
	change_electricity(has_electricity)


func plug_plugged(plug):
	my_plug = plug
	if my_outputs.size() == 0: # ie this socket is not an input one
		plug.change_electricity(has_electricity)
	else: # the socket is an input
		change_electricity(plug.has_electricity)


func plug_unplugged(plug):
	my_plug = null
	if my_outputs.size() == 0: # ie this socket is not an input one
		plug.change_electricity(false)
	else: # the socket is an input
		change_electricity(false) 
	


func change_electricity(value):
	if !is_energy_source:
		has_electricity = value
		$has_electricity_visualiser.visible = value
		if my_plug != null:
			my_plug.change_electricity(value)
		if my_outputs.size() != 0:
			for output in my_outputs:
				output.change_electricity(value)
