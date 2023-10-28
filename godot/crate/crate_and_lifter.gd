extends Node2D

func _ready():
	if GlobalVars.moved_crate:
		%HugeCrate.global_position = %LifterAlignColumn.global_position

