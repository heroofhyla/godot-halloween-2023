extends Control

enum {IDLE, BUSY, SHOWING_MESSAGE}
var state: int = IDLE

signal cutscene_started

func _ready():
	pass

func show_message(message: String):
	print("show_message")
	%TextBoxBG.visible = true
	%TextBoxLabel.text = message
	state = SHOWING_MESSAGE
	cutscene_started.emit()

func _input(event: InputEvent):
	if event.is_action_pressed("interact") and state == SHOWING_MESSAGE:
		print("hide_message")
		state = IDLE
		%TextBoxBG.visible = false
		get_viewport().set_input_as_handled()
