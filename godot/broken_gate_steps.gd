extends CutsceneSteps

func _steps():
	if GlobalVars.broken_gate_progress == GlobalVars.NEVER_INTERACTED:
		play_animated_sprite($"../Gate/AnimatedSprite2D", "fail_opening")
		GlobalVars.broken_gate_progress = GlobalVars.POWER_OUT
	elif GlobalVars.broken_gate_progress == GlobalVars.POWER_OUT:
		if GlobalVars.found_fuse:
			show_message("You replaced the fuse.")
			GlobalVars.broken_gate_progress = GlobalVars.POWER_RESTORED
		else:
			show_messages([
				"Nothing happened.",
				"The fuse has blown."
			])
	elif GlobalVars.broken_gate_progress == GlobalVars.POWER_RESTORED:
		play_animated_sprite($"../Gate/AnimatedSprite2D", "opening")
		cutscene_set($"../Gate/CollisionShape2D", "disabled", true)
		GlobalVars.broken_gate_progress = GlobalVars.GATE_OPENED
	elif GlobalVars.broken_gate_progress == GlobalVars.GATE_OPENED:
		show_message("The gate is already open.")
