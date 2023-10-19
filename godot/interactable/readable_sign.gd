class_name ReadableSign
extends CutsceneSteps

@export_multiline var messages: Array[String]
func _steps():
	show_messages(messages)
