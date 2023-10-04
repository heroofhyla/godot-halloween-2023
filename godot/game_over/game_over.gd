extends Node2D


func _input(event):
	if event.is_action("interact"):
		SceneManager.change_scene("res://title/title.tscn")
