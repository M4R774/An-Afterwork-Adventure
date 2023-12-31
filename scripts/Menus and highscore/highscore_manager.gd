extends Control

@export var playername_prompt_path: NodePath
@onready var playername_prompt = get_node(playername_prompt_path)
@export var namefield_path: NodePath 
@onready var namefield: Node = get_node(namefield_path)
@export var loading_icon_path: NodePath 
@onready var loading_icon: Node2D= get_node(loading_icon_path)
@export var to_main_menu_path: NodePath 
@onready var to_main_menu: Node= get_node(to_main_menu_path)
@export var local_highscores_text_path: NodePath
@onready var local_highscores_text: RichTextLabel = get_node(local_highscores_text_path)
@export var online_highscores_text_path: NodePath
@onready var online_highscores_text: RichTextLabel = get_node(online_highscores_text_path)

var http_client = HTTPClient.new()
var back_end_url = ""
var score

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	score = HIGHSCORE_SINGLETON.get_highscore()
	back_end_url = "https://" + SECRETS.DOMAIN + "/highscores/" + HIGHSCORE_SINGLETON.GAME_NAME
	playername_prompt.visible = false
	to_main_menu.grab_focus()
	update_highscores_table()
	check_if_players_score_is_high_enough()


func update_highscores_table():
	update_local_highscores_table()

	loading_icon.visible = true
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed",Callable(self,"_on_get_highscores_request_completed"))
	request.request(back_end_url)


func update_local_highscores_table():
	var local_highscores_text_content = ""
	for player in HIGHSCORE_SINGLETON.LOCAL_HIGHSCORES:
		if player["score"] == null:
			local_highscores_text_content += ("%-21s" % player["name"] + str(player["score"]) + "\n")
		else:
			local_highscores_text_content += ("%-21s" % player["name"] + str(abs(player["score"])) + "\n")
	local_highscores_text.text = local_highscores_text_content


func _on_get_highscores_request_completed(_result, response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	if response_code == 200:
		online_highscores_text.text = response_body.replace("-", "")
	else:
		online_highscores_text.text = "High score server is currently unavailable."
	loading_icon.visible = false


func check_if_players_score_is_high_enough():
	if score == null:
		return

	# Offline
	if HIGHSCORE_SINGLETON.score_is_high_enough_for_local_leaderboard(score):
		ask_for_players_name()
	else:
		# Online
		var request = HTTPRequest.new()
		add_child(request)
		request.connect("request_completed",Callable(self,"_on_check_if_high_enough_request_completed"))
		request.request(back_end_url + "?score=" + str(score))


func _on_check_if_high_enough_request_completed(_result, _response_code, _headers, body):
	var response_body = body.get_string_from_utf8()
	if response_body == "true":
		ask_for_players_name()
	else:
		print("Score is not high enough...")


func ask_for_players_name():
	playername_prompt.visible = true
	namefield.grab_focus()


func post_highscores_online():
	HIGHSCORE_SINGLETON.add_new_local_highscore(score)
	update_local_highscores_table()
	loading_icon.visible = true
	var payload_dict = {"name":HIGHSCORE_SINGLETON.PLAYER_NAME, "score":score}
	var body = http_client.query_string_from_dict(payload_dict)
	var auth=str("Basic ",
			Marshalls.utf8_to_base64(
				str(SECRETS.USERNAME, ":", SECRETS.PASSWORD)))
	var headers = ["Content-Type: application/x-www-form-urlencoded",
					"Content-Length: " + str(body.length()),
					"Authorization: "+auth]
	var request = HTTPRequest.new()
	add_child(request)
	request.connect("request_completed",Callable(self,"_on_post_highscores_request_completed"))
	request.request(back_end_url, headers, 2, body)
	score = null
	HIGHSCORE_SINGLETON.SCORE = null
	HIGHSCORE_SINGLETON.START_TIME = null
	to_main_menu.grab_focus()


func _on_post_highscores_request_completed(_result, _response_code, _headers, _body):
	update_highscores_table()
