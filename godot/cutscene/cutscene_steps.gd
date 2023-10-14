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

func activate_node(node_path: String):
	steps.push_back(func():
		get_node(node_path).activate()
	)

func play_animated_sprite(sprite: AnimatedSprite2D, animation: String):
	steps.push_back(func():
		sprite.play(animation)
		await sprite.animation_finished
	)

func _steps():
	pass
