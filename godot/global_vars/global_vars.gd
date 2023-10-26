extends Node

enum {NEVER_INTERACTED, POWER_OUT, POWER_RESTORED, GATE_OPENED}

var drink_count: int
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
	drink_count = 0
	has_west_hall_key = false
	has_locker_key = false
	teleport_target = ""
	player_facing = 0
	player_health = 5
	player_max_health = 5

func set_or_add(var_name: String):
	if typeof(get(var_name)) == TYPE_BOOL:
		set(var_name, true)
	elif typeof(get(var_name)) == TYPE_INT:
		set(var_name, get(var_name) + 1)

func local_set(node: Node, property: String, value):
	local_vars[node.get_path() as String + ":" + property] = value

func local_get(node: Node, property: String, default):
	return local_vars.get(node.get_path() as String + ":" + property, default)

func _ready():
	reset()
