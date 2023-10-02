extends Node

var hint_delay = 60000
var prompt_active = false
var prompt = "Would you like a hint? (y/n)"
var hints = [
"I think I saw a keyboard in the starting room",
"Orange post-it note on the bottom of the keyboard... Orange door... hmmm...",
"The whiteboard in the cafeteria looks interesting",
"Red text on the whiteboard... red door upstairs... hmmm...",
"There was electricity in the starting room for the radio and transmitter",
"Viisi Neljä Kolme Kaksi",
"I need to find the keycard. Maybe downstairs somewhere?",
"I wonder where the keycard fits. Maybe upstairs? ",
"Leap of faith",
]
var completed_tasks = [
false,
false,
false,
false,
false,
false,
false,
false,
false,
false,
]
var time_stamp_for_last_progress = 0

func _ready():
	time_stamp_for_last_progress = Time.get_ticks_msec()
	$Hint.visible = false

func _physics_process(_delta):
	if Time.get_ticks_msec() - time_stamp_for_last_progress > hint_delay and !prompt_active:
		hint_delay = 60000
		prompt_active = true
		prompt_hint()

func _input(_event):
	if prompt_active:
		if Input.is_action_just_pressed("accept_hint"):
			show_hint()
		elif Input.is_action_just_pressed("refuse_hint"):
			hint_delay = 120000
			hide_hint()

func player_made_progress(progress: int):
	time_stamp_for_last_progress = Time.get_ticks_msec()
	completed_tasks[progress] = true
	hide_hint()
		

func prompt_hint():
	$Hint.visible = true
	$Hint.text = prompt

func show_hint():
	$Hint.visible = true
	var i = 0
	for completed_task in completed_tasks:
		if !completed_task:
			$Hint.text = hints[i]
			return
		i += 1

func hide_hint():
	$Hint.visible = false
	prompt_active = false
	time_stamp_for_last_progress = Time.get_ticks_msec()
