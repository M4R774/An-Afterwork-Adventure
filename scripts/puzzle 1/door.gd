extends MeshInstance3D

var has_opened = false # hack to not play dooring closing animation at start

func _on_plug_electricity_changed(value):
	if value:
		$AnimationPlayer.play("open_door")
		has_opened = true
	else:
		if has_opened:
			$AnimationPlayer.play_backwards("open_door")
