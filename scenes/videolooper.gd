extends VideoStreamPlayer

@export var one_shot_video: bool = false


func _on_finished():
	if (one_shot_video):
		visible = false
	else:	
		play()
