@tool
extends Node

func has_collision_shapes():
	for child in owner.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			print("found collision shape: %s" % child)
			return true
	return false

func validate():
	if not Engine.is_editor_hint():
		return false
	if not owner:
		return false
	if has_collision_shapes():
		return false
	if not get_tree().edited_scene_root is Room:
		return false
	
	return true

func spawn_collision_shape():
	var new_collision_shape = CollisionShape2D.new()
	var new_shape = RectangleShape2D.new()
	new_shape.set_size(Vector2(10,10))
	new_collision_shape.shape = new_shape
	owner.add_child(new_collision_shape, true, INTERNAL_MODE_DISABLED)
	new_collision_shape.owner = get_tree().edited_scene_root

func _ready():
	if not validate():
		return
	spawn_collision_shape.call_deferred()
