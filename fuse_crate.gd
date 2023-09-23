extends StaticBody2D

func _ready():
	$Interactable.activated.connect(_on_Interactable_activated)

func _on_Interactable_activated():
	Cutscene.start_sync(func():
		if GlobalVars.found_fuse:
			await Cutscene.show_message("THE CRATE IS EMPTY")
		else:
			await Cutscene.show_message("YOU FOUND A FUSE IN THE CRATE")
			GlobalVars.found_fuse = true
	)
