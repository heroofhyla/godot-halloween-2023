extends CutsceneSteps

@export var start_open: bool = false
@export var locked: bool = false

func setup():
	if start_open:
		local_set("open", true)
	local_set("locked", local_get("locked", locked))
	if local_get("open", false):
		$"../DoorSprite".play("open")
	
func _steps():
	if local_get("open", false):
		print("already open!")
		activate_node(owner.get_path() as String)
	else:
		if local_get("locked", false) and not GlobalVars.has_locker_key:
			show_message("It's locked.")
		else:
			play_animated_sprite($"../DoorSprite", "open")
			if local_get("locked", false):
				show_message("You unlocked it with the\nlocker master key.")
			local_set("open", true)
			activate_node(owner.get_path() as String)
