@tool
extends Node2D

@export var start_open: bool:
	set(val): 
		%LockerDoorBehavior.start_open = val
		if val:
			$Interactable/DoorSprite.play("open")
		else:
			$Interactable/DoorSprite.play("closed")
	get: return %LockerDoorBehavior.start_open
@export var locked: bool:
	set(val): %LockerDoorBehavior.locked = val
	get: return %LockerDoorBehavior.locked

func _ready():
	%LockerDoorBehavior.setup()

func activate():
	for child in get_children():
		if child.has_method("activate"):
			child.activate()
