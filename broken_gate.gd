extends Node2D

enum {NEVER_INTERACTED, POWER_OUT}
var event_progress:int = NEVER_INTERACTED

func _ready():
	$ControlPanel.activated.connect(_on_ControlPanel_activated)

func _on_ControlPanel_activated():
	if event_progress == NEVER_INTERACTED:
		Cutscene.state = Cutscene.BUSY
		Cutscene.cutscene_started.emit()
		$Gate/AnimatedSprite2D.play("fail_opening")
		await $Gate/AnimatedSprite2D.animation_finished
		Cutscene.state = Cutscene.IDLE
		event_progress = POWER_OUT
	elif event_progress == POWER_OUT:
		Cutscene.show_message("NOTHING HAPPENED")
