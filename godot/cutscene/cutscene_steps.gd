class_name CutsceneSteps
extends Node

var steps: Array[Callable] = []

func activate():
	steps.clear()
	_steps()
	Cutscene.start_sync(func():
		for step in steps:
			await step.call()
	)

func show_message(message: String):
	steps.push_back(Cutscene.show_message.bind(message))

func show_messages(messages: Array):
	steps.push_back(Cutscene.show_messages.bind(messages))

func cutscene_set(object: Object, property: String, value):
	steps.push_back(func():
		object.set(property, value)
	)

func cutscene_local_set(property: String, value):
	steps.push_back(local_set.bind(property, value))

func local_set(property: String, value):
	GlobalVars.local_vars[get_path() as String + ":" + property] = value

func local_get(property: String, default):
	return GlobalVars.local_vars.get(get_path() as String + ":" + property, default)

func activate_node(node_path: String):
	steps.push_back(func():
		get_node(node_path).activate()
	)

func activate_children():
	steps.push_back(func():
		for child in get_children():
			if child.has_method("activate"):
				child.activate()
	)

func play_animated_sprite(sprite: AnimatedSprite2D, animation: String):
	steps.push_back(func():
		sprite.play(animation)
		await sprite.animation_finished
	)

func play_animation(player: AnimationPlayer, animation: String):
	steps.push_back(func():
		player.play(animation)
		await player.animation_finished
	)

func cutscene_do(callable: Callable):
	steps.push_back(func():
		await callable.call()
	)

func _steps():
	pass
