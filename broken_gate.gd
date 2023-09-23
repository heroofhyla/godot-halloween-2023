extends Node2D

enum {NEVER_INTERACTED, POWER_OUT}
var event_progress:int = NEVER_INTERACTED

func _ready():
	$ControlPanel.activated.connect(_on_ControlPanel_activated)

func _on_ControlPanel_activated():
	Cutscene.start_sync(func():
		if event_progress == NEVER_INTERACTED:
			$Gate/AnimatedSprite2D.play("fail_opening")
			await $Gate/AnimatedSprite2D.animation_finished
			event_progress = POWER_OUT
		elif event_progress == POWER_OUT:
			await Cutscene.show_messages([
				"NOTHING HAPPENED",
				"THE FUSE HAS BLOWN"
			])
	)
