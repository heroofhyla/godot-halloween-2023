extends StaticBody2D

@export var activator: Node

func _ready():
	activator.activated.connect(_on_activator_activated)

func _on_activator_activated():
	$AnimatedSprite2D.play("fail_opening")
