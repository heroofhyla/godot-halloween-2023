extends Node2D

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
func _input(event):
	if event.is_action("interact"):
		SceneManager.change_scene("res://room/hallway.tscn")