extends Node

enum {NEVER_INTERACTED, POWER_OUT, POWER_RESTORED, GATE_OPENED}

var has_west_hall_key: bool
var has_locker_key: bool
var teleport_target: String
var player_facing: int
var player_health: int
var player_max_health: int
var local_vars: Dictionary

var player:
	get: return get_tree().get_nodes_in_group("player")[0]

func reset():
	has_west_hall_key = false
	has_locker_key = false
	teleport_target = ""
	player_facing = 0
	player_health = 5
	player_max_health = 5

func _ready():
	reset()
