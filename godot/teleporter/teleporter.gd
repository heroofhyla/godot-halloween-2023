@tool

extends Interactable
@export_file("*.tscn") var target_map: String
@export var teleport_target: String

func activate():
	EventBus.room_changing.emit()
	GlobalVars.teleport_target = teleport_target
	SceneManager.change_scene(target_map)

func has_no_collision_shapes():
	for child in get_children():
		if child is CollisionShape2D or CollisionPolygon2D:
			return false
	return true

func _ready():
	super._ready()
	if Engine.is_editor_hint() and has_no_collision_shapes():
		var new_collision_shape = CollisionShape2D.new()
		var new_shape = RectangleShape2D.new()
		new_shape.set_size(Vector2(10,10))
		new_collision_shape.shape = new_shape
		add_child(new_collision_shape, true, INTERNAL_MODE_DISABLED)
		new_collision_shape.owner = get_tree().edited_scene_root
