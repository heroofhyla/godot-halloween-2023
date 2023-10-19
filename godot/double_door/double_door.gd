@tool
extends Node2D

@export var start_open: bool:
	set(val): 
		%DoubleDoorSteps.start_open = val
		if val:
			open()
		else:
			$Interactable/DoorSprite.play("closed")
	get: return %DoubleDoorSteps.start_open

@export var locked: bool:
	set(val): %DoubleDoorSteps.locked = val
	get: return %DoubleDoorSteps.locked

@export var key_var: String:
	set(val): %DoubleDoorSteps.key_var = val
	get: return %DoubleDoorSteps.key_var

@export var key_pretty_name: String:
	set(val): %DoubleDoorSteps.key_pretty_name = val
	get: return %DoubleDoorSteps.key_pretty_name

func _ready():
	%DoubleDoorSteps.setup()

func open():
	$Interactable/DoorSprite.play("open")
	$Interactable/CollisionShape2D.disabled = true
	$DynamicCollision/CollisionShape2D.disabled = true

func activate():
	open()
