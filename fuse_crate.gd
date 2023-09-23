extends StaticBody2D

func _ready():
	$Interactable.activated.connect(_on_Interactable_activated)

func _on_Interactable_activated():
	Cutscene.start_sync(func():
		if GlobalVars.found_fuse:
			await Cutscene.show_message("The crate is empty.")
		else:
			await Cutscene.show_message("You found a fuse in the\ncrate.")
			GlobalVars.found_fuse = true
	)
