class_name Interactable
extends Area2D

signal activated

func interact():
	activated.emit()

func _ready():
	$InteractHint.visible = false
	EventBus.top_interactable_changed.connect(_on_EventBus_top_interactable_changed)

func _on_EventBus_top_interactable_changed(top_interactable: Interactable):
	$InteractHint.visible = (top_interactable == self)
