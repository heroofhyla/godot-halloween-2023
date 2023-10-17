extends CutsceneSteps

@export_multiline var found_messages: Array[String]
@export_multiline var empty_messages: Array[String]
@export var var_to_set: String = ""

func _steps():
	if local_get("found", false):
		if empty_messages:
			show_messages(empty_messages)
	else:
		if found_messages:
			show_messages(found_messages)
			if var_to_set:
				GlobalVars.set(var_to_set, true)
				local_set("found", true)
			else:
				printerr("No variable set for " + (get_path() as String))
