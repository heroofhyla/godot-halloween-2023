extends CutsceneSteps

func _steps():
	show_message("You examine the control panel.")
	show_message("It's very dusty.")
	cutscene_set(GlobalVars, "found_key", true)
	
