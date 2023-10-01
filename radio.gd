extends Node3D


func _on_plug_electricity_changed(value):
	if value:
		$AnimationPlayer.play("open_door")
	else:
		$AnimationPlayer.play_backwards("open_door")
