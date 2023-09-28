extends Node
@export_file("*.tscn") var target_map: String
@export var teleport_target: String

func activate():
	EventBus.room_changing.emit()
	GlobalVars.teleport_target = teleport_target
	SceneManager.change_scene(target_map)
