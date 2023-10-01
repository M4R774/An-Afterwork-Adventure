extends Node3D

@export var correct_password = "1234"
@export var door: Interactable = null

var is_audio_playing = false
var password = ""

@onready var pressed_audio = $PressedAudioStream
@onready var correct_audio = $CorrectAudioStream
@onready var wrong_audio = $WrongAudioStream
@onready var keys = $Keys
@onready var password_label = $Label3D

signal on_correct_password
signal on_wrong_password
signal on_clear_password
signal on_keypad_press

func _ready():
	on_correct_password.connect(_on_Keypad_on_correct_password)
	if door == null:
		print("Error: Door not set for keypad")
	var i = 0
	for child in keys.get_children():
		if child is StaticBody3D:
			child.set_number(child.get_number())
			i += 1
			child.on_interact.connect(on_button_interact)
	password_label.text = ""

func on_button_interact(value):
	if is_audio_playing:
		return
	is_audio_playing = true
	pressed_audio.playing = true
	# print("interacted with " + str(value))
	if value == ".":
		if password == correct_password:
			correct_audio.play()
			emit_signal("on_correct_password", password)
		else:
			wrong_audio.play()
			emit_signal("on_wrong_password", password)
		password = ""
	elif value == "C":
		emit_signal("on_clear_password", password)
		password = ""
	else:  # digit key is pressed
		if password.length() == correct_password.length():
			return
		password += value
		emit_signal("on_keypad_press", password)

	password_label.text = password

func _on_AudioStreamPlayer3D_finished():
	is_audio_playing = false

func _on_Keypad_on_correct_password(password):
	print("correct password")
	if door == null:
		print("Error: Password was correct, but the keypad was not connected to any door or interactable.")
	else:
		door.open()
