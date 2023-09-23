extends Node2D

enum {NEVER_INTERACTED, POWER_OUT, POWER_RESTORED, GATE_OPENED}

func _ready():
	$ControlPanel.activated.connect(_on_ControlPanel_activated)
	if GlobalVars.broken_gate_progress == -1:
		GlobalVars.broken_gate_progress = NEVER_INTERACTED
	
	if GlobalVars.broken_gate_progress == GATE_OPENED:
		$Gate/AnimatedSprite2D.play("open")
		$Gate/CollisionShape2D.disabled = true

func _on_ControlPanel_activated():
	Cutscene.start_sync(func():
		if GlobalVars.broken_gate_progress == NEVER_INTERACTED:
			$Gate/AnimatedSprite2D.play("fail_opening")
			await $Gate/AnimatedSprite2D.animation_finished
			GlobalVars.broken_gate_progress = POWER_OUT
		elif GlobalVars.broken_gate_progress == POWER_OUT:
			if GlobalVars.found_fuse:
				await Cutscene.show_message("YOU REPLACED THE FUSE.")
				GlobalVars.broken_gate_progress = POWER_RESTORED
			else:
				await Cutscene.show_messages([
					"NOTHING HAPPENED",
					"THE FUSE HAS BLOWN"
				])
		elif GlobalVars.broken_gate_progress == POWER_RESTORED:
			$Gate/AnimatedSprite2D.play("opening")
			await $Gate/AnimatedSprite2D.animation_finished
			$Gate/CollisionShape2D.disabled = true
			GlobalVars.broken_gate_progress = GATE_OPENED
		elif GlobalVars.broken_gate_progress == GATE_OPENED:
			await Cutscene.show_message("THE GATE IS ALREADY OPEN.")
	)
