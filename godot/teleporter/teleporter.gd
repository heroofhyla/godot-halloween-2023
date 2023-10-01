extends Interactable
@export_file("*.tscn") var target_map: String
@export var teleport_target: String

func activate():
	GlobalVars.teleport_target = teleport_target
	SceneManager.change_scene(target_map)
