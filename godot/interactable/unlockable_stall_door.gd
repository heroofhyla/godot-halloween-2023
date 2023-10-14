extends CutsceneSteps

@export_multiline var messages: Array[String]

func _steps():
	if GlobalVars.found_bathroom_key:
		activate_node(str(self.get_path()) + "/../StallDoor")
	else:
		show_messages(messages)
