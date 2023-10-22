class_name FindableItem
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
				GlobalVars.set_or_add(var_to_set)
				local_set("found", true)
			else:
				printerr("No variable set for " + (get_path() as String))
