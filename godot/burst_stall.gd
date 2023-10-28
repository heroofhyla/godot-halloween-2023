extends CutsceneSteps

func _steps():
	if GlobalVars.moved_crate:
		show_messages([
			"Something kicked down the\ndoor to this stall.",
			"Dark liquid is splattered\naround.",
			"It's still wet."
		])
	else:
		show_message("It's locked.")
