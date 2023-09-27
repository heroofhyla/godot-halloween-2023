class_name TouchTrigger
extends Area2D

signal activated

func interact():
	activated.emit()
	for child in get_children():
		if child.has_method("activate"):
			child.activate()
	for sibling in get_parent().get_children():
		if sibling.has_method("activate"):
			sibling.activate()
