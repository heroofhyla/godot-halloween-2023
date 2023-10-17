extends Node

enum {NEVER_INTERACTED, POWER_OUT, POWER_RESTORED, GATE_OPENED}

var has_necklace: bool
var has_gloves: bool
var has_floppy_disk: bool
var found_locker_key: bool
var found_fuse: bool
var broken_gate_progress: int
var teleport_target: String
var player_facing: int
var player_health: int
var player_max_health: int
var local_vars: Dictionary

var player:
	get: return get_tree().get_nodes_in_group("player")[0]

func reset():
	has_gloves = false
	has_floppy_disk = false
	has_necklace = false
	found_locker_key = false
	found_fuse = false
	broken_gate_progress = NEVER_INTERACTED
	teleport_target = ""
	player_facing = 0
	player_health = 5
	player_max_health = 5

func _ready():
	reset()
