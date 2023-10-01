class_name CutscenePlayer
extends Control

const SEC_PER_CHAR :float = 0.05

enum {IDLE, BUSY, TYPING_MESSAGE, SHOWING_MESSAGE}
var state: int = IDLE
var tween: Tween = null

signal cutscene_started
signal message_finished
func _ready():
	pass

func start_sync(lambda: Callable):
	state = BUSY
	cutscene_started.emit()
	await lambda.call()
	state = IDLE

func show_messages(messages: Array):
	for message in messages:
		await show_message(message)

func show_message(message: String):
	print("show_message")
	%TextBoxBG.visible = true
	await get_tree().process_frame
	%TextBoxLabel.text = message
	%TextBoxLabel.visible_characters = 0
	%TextBoxLabel.visible = true
	state = TYPING_MESSAGE
	cutscene_started.emit()
	var message_time = message.length() * SEC_PER_CHAR
	tween = get_tree().create_tween()
	tween.tween_property(%TextBoxLabel, "visible_characters", message.length(), message_time)
	tween.finished.connect(_on_text_tween_complete)
	await message_finished

func _on_text_tween_complete():
	state = SHOWING_MESSAGE

func _input(event: InputEvent):
	if event.is_action_pressed("interact"):
		if state == TYPING_MESSAGE:
			tween.kill()
			%TextBoxLabel.visible_characters = -1
			state = SHOWING_MESSAGE
		elif state == SHOWING_MESSAGE:
			print("hide_message")
			state = BUSY
			%TextBoxBG.visible = false
			%TextBoxLabel.visible = false
			get_viewport().set_input_as_handled()
			message_finished.emit()
