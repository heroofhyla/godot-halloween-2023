extends CutsceneSteps

@export var start_open: bool = false
@export var locked: bool = false
@export var key_var: String = ""
@export var key_pretty_name: String = ""
func setup():
	if start_open:
		local_set("open", true)
	local_set("locked", local_get("locked", locked))
	if local_get("open", false):
		owner.activate()
	
func _steps():
	if local_get("open", false):
		pass
	else:
		if local_get("locked", false) and not GlobalVars.get(key_var):
			show_message("It's locked.")
		else:
			activate_node(owner.get_path() as String)
			if local_get("locked", false):
				show_message("You unlocked it with the\n." + key_pretty_name)
			local_set("open", true)

