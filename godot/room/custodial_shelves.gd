extends CutsceneSteps

func _steps():
	if GlobalVars.found_bathroom_key:
		show_message("The shelves are lined with\ncleaning supplies.")
	else:
		show_messages([
			"The shelves are lined with\ncleaning supplies.",
			"You also found a key.",
			"The tag on the key says\n\"Stalls\"."
		])
		GlobalVars.found_bathroom_key = true
