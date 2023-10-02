extends Node

var prompt_active = false
var prompt = "Would you like a hint? (y/n)"
var hints = [
"I think I saw a keyboard in the starting room",
"Orange post-it note on the bottom of the keyboard... Orange door... hmmm...",
"The whiteboard in the cafeteria looks interesting",
"Red text on the whiteboard... red door upstairs... hmmm...",
"I think I saw a radio in the cafeteria",
"I think I saw a radio transmitter in the upstairs",
"There was electricity in the starting room for the radio and transmitter",
"Viisi Neljä Kolme Kaksi",
"I need to find the keycard. Maybe downstairs somewhere?",
"I wonder where the keycard fits. Maybe upstairs? ",
]


var time_stamp_for_last_progress = 0
var current_progress = 0

func _physics_process(_delta):
    if Time.get_ticks_msec() - time_stamp_for_last_progress > 10000 and !prompt_active:
        prompt_active = true
        prompt_hint()

func _input(_event):
    if prompt_active:
        if Input.is_action_just_pressed("accept_hint"):
            show_hint()
        elif Input.is_action_just_pressed("refuse_hint"):
            hide_hint()

func player_made_progress():
    time_stamp_for_last_progress = Time.get_ticks_msec()
    current_progress += 1
    hide_hint()
        

func prompt_hint():
    print(prompt)

func show_hint():
    print(hints[current_progress])

func hide_hint():
    prompt_active = false
    time_stamp_for_last_progress = Time.get_ticks_msec()
    print("refused")
