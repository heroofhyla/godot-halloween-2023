extends Node2D

@export_file("*.tscn") var target_map: String
@export var teleport_target: String

func _ready():
	$TouchTrigger.activated.connect(_on_TouchTrigger_activated)
	for i in range(get_child_count() - 1, -1, -1):
		var child = get_child(i)
		if child is CollisionShape2D:
			remove_child(child)
			$TouchTrigger.add_child(child)

func _on_TouchTrigger_activated():
	EventBus.room_changing.emit()
	GlobalVars.teleport_target = teleport_target
	get_tree().change_scene_to_file(target_map)
