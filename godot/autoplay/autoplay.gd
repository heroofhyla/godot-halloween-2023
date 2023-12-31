class_name Autoplay
extends Node

@export var repeating: bool = false

func _ready():
	if SceneManager.scene_changing:
		await EventBus.room_changed

	if repeating or not GlobalVars.local_get(self, "activated", false):
		for child in get_children():
			if child.has_method("activate"):
				child.activate()
		GlobalVars.local_set(self, "activated", true)
