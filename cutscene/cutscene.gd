class_name CutscenePlayer
extends Control

enum {IDLE, BUSY, SHOWING_MESSAGE}
var state: int = IDLE

signal cutscene_started
signal message_finished
func _ready():
	pass

func start_sync(lambda: Callable):
	state = BUSY
	cutscene_started.emit()
	await lambda.call()
	state = IDLE

func show_message(message: String):
	await show_message_internal(message).message_finished

func show_message_internal(message: String) -> CutscenePlayer:
	print("show_message")
	%TextBoxBG.visible = true
	%TextBoxLabel.text = message
	state = SHOWING_MESSAGE
	cutscene_started.emit()
	return self

func _input(event: InputEvent):
	if event.is_action_pressed("interact") and state == SHOWING_MESSAGE:
		print("hide_message")
		state = IDLE
		%TextBoxBG.visible = false
		get_viewport().set_input_as_handled()
		message_finished.emit()
