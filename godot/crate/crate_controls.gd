extends CutsceneSteps

func _steps():
	if GlobalVars.moved_crate:
		show_message("You've already moved the\ncrate out of the way.")
	else:
		show_message("You operate the claw.") 
		cutscene_do(func():
			var tween = get_tree().create_tween()
			tween.tween_property(%Lifter, "global_position", %LifterAlignColumn.global_position, 3)
			tween.tween_property(%Lifter, "global_position", %LifterAlignBox.global_position, 3)
			tween.play()
			await tween.finished
		)
		play_animation(%CrateAndLifterAnimationPlayer, "extend_claw")
		play_animation(%CrateAndLifterAnimationPlayer, "close_clamps")
		play_animation(%CrateAndLifterAnimationPlayer, "lift_box")
		cutscene_set(%HugeCrate, "z_index", 1)
		cutscene_do(func():
			var tween = get_tree().create_tween()
			tween.tween_property(%Lifter, "global_position", %LifterAlignColumn.global_position, 3)
			tween.parallel()
			tween.tween_property(%HugeCrate, "global_position", %LifterAlignColumn.global_position, 3)
			tween.play()
			await tween.finished
		)
		play_animation(%CrateAndLifterAnimationPlayer, "lower_box")
		play_animation(%CrateAndLifterAnimationPlayer, "open_clamps")
		play_animation(%CrateAndLifterAnimationPlayer, "retract_claw")
		cutscene_do(func():
			var tween = get_tree().create_tween()
			tween.tween_property(%Lifter, "global_position", %LifterInitialSpot.global_position, 3)
			tween.play()
			await tween.finished
		)
		cutscene_set(%HugeCrate, "z_index", 0)
		cutscene_set(GlobalVars, "moved_crate", true)
