extends Node2D

var PLAYER_NAME = null
var SCORE = null
var START_TIME = null

var GAME_NAME : String = ""
var LOCAL_HIGHSCORES : Array = []


func _ready():
	load_highscores_from_disk()
	GAME_NAME = ProjectSettings.get_setting('application/config/name')
	assert(GAME_NAME != "")


func get_highscore():
	if START_TIME == null:
		return null
	return (START_TIME - Time.get_ticks_msec()) / 1000


func score_is_high_enough_for_local_leaderboard(score):
	if LOCAL_HIGHSCORES[-1]["score"] == null:
		return true
	elif LOCAL_HIGHSCORES.size() < 10 or LOCAL_HIGHSCORES[-1]["score"] < score:
		return true
	else:
		return false


func add_new_local_highscore(new_score):
	if score_is_high_enough_for_local_leaderboard(new_score):
		LOCAL_HIGHSCORES.append({"name": PLAYER_NAME, "score":new_score})
	LOCAL_HIGHSCORES.sort_custom(Callable(self,"customPlayerComparison"))
	if LOCAL_HIGHSCORES.size() > 10:
		LOCAL_HIGHSCORES.pop_back()
	save_highscores_to_disk()


func customPlayerComparison(player_a, player_b):
	if player_a["score"] == null:
		return false
	elif player_b["score"] == null:
		return true
	else:
		return player_a["score"] > player_b["score"]


func save_highscores_to_disk():
	var save_file = FileAccess.open("user://highscores.save", FileAccess.WRITE)
	save_file.store_var(LOCAL_HIGHSCORES, true)


func load_highscores_from_disk():
	if not FileAccess.file_exists("user://highscores.save"):
		return # Error! We don't have a save to load.
	var save_file = FileAccess.open("user://highscores.save", FileAccess.READ)
	var array = save_file.get_var(true)
	LOCAL_HIGHSCORES = array
