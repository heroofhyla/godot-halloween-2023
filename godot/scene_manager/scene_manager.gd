extends Node

var scene_changing: bool = false

func fade_out():
	$AnimationPlayer.play("fade_out")
	await $AnimationPlayer.animation_finished

func fade_in():
	$AnimationPlayer.play("fade_in")
	await $AnimationPlayer.animation_finished

func change_scene(new_scene: String):
	scene_changing = true
	EventBus.room_changing.emit()
	Cutscene.state = Cutscene.BUSY
	await fade_out()
	get_tree().change_scene_to_file(new_scene)
	await fade_in()
	Cutscene.state = Cutscene.IDLE
	scene_changing = false
	EventBus.room_changed.emit()
