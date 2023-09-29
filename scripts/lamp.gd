extends RigidBody3D

var has_electricity = false


func change_electricity(value):
	has_electricity = value
	$MeshInstance3D/OmniLight3D.light_energy = value
