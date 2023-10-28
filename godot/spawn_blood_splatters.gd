extends Node

func _ready():
	if GlobalVars.moved_crate:
		$Splatters.visible = true
		if has_node("ClosedDoor"):
			$ClosedDoor.visible = false
