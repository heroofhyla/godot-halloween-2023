extends CutsceneSteps

func _steps():
	if GlobalVars.found_fuse:
		show_message("The crate is empty.")
	else:
		show_message("You found a fuse in the\ncrate.")
		GlobalVars.found_fuse = true
