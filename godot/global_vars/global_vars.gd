extends Node

enum {NEVER_INTERACTED, POWER_OUT, POWER_RESTORED, GATE_OPENED}

var found_fuse: bool = false
var broken_gate_progress: int = NEVER_INTERACTED
var teleport_target: String = ""
var player_facing = 0
