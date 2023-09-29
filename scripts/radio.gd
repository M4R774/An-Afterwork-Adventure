extends RigidBody3D

var has_electricity = false


func change_electricity(value):
	print("asd")
	has_electricity = value
	if has_electricity:
		# debugging to find out why audio sometimes fizzles
		#$".".freeze = true #.linear_velocity = Vector3.ZERO
		$AudioStreamPlayer3D.play()
	else:
		$AudioStreamPlayer3D.stop()
		#$".".freeze = false
