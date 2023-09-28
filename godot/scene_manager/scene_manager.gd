extends Node

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished

func fade_in():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func change_scene(new_scene: String):
	Cutscene.state = Cutscene.BUSY
	await fade_out()
	get_tree().change_scene_to_file(new_scene)
	await fade_in()
	Cutscene.state = Cutscene.IDLE
