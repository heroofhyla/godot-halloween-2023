extends Node2D

enum {STALL_OPEN, STALL_CLOSED}
var state = STALL_CLOSED:
	set(val):
		state = val
		if state == STALL_CLOSED:
			$StallDoorUpper.frame = 9
			$StallDoorLower.frame = 15
		else:
			$StallDoorUpper.frame = 6
			$StallDoorLower.frame = 12

func activate():
	if state == STALL_CLOSED:
		state = STALL_OPEN
	else:
		state = STALL_CLOSED
