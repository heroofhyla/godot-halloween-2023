class_name Interactable
extends Area2D

@export_enum("touch", "interact") var trigger_type: String = "interact"
@export var activate_children: bool = true
@export var activate_siblings: bool = false
@export var activate_parent: bool = false
@export var activate_owner: bool = false
@export var activate_self: bool = true
@export var activate_additional: Array[Node]
signal activated

func interact():
	activated.emit()
	if activate_children:
		for child in get_children():
			if child.has_method("activate"):
				child.activate()
	if activate_siblings:
		for sibling in get_parent().get_children():
			if sibling.has_method("activate"):
				sibling.activate()
	if activate_parent and get_parent().has_method("activate"):
		get_parent().activate()
	if activate_owner and owner != null and owner.has_method("activate"):
		owner.activate()
	if activate_self:
		activate()

	for node in activate_additional:
		if node.has_method("activate"):
			node.activate()

func activate():
	pass

func _ready():
	if Engine.is_editor_hint():
		return
	if has_node("InteractHint"):
		$InteractHint.visible = false
	EventBus.top_interactable_changed.connect(_on_EventBus_top_interactable_changed)

func _on_EventBus_top_interactable_changed(top_interactable: Interactable):
	if has_node("InteractHint"):
		$InteractHint.visible = (top_interactable == self)
