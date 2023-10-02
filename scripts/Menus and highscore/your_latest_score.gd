extends Label


func _ready():
	if HIGHSCORE_SINGLETON.get_highscore() != null:
		self.text = "Your latest time: " + str(abs(HIGHSCORE_SINGLETON.get_highscore())) + " seconds"
	else:
		self.text = ""
