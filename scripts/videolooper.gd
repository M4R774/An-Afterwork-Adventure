extends VideoStreamPlayer

@export var one_shot_video: bool = false

func _ready():
	if one_shot_video && HIGHSCORE_SINGLETON.get_highscore() == null:
		visible = false
		$"../AudioStreamPlayer".stop()

func _on_finished():
	if (one_shot_video):
		visible = false
	else:	
		play()
