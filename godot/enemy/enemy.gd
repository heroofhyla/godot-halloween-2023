extends CharacterBody2D

const SPEED: float = 48.0
const LUNGE_SPEED: float = 128.0
const LUNGE_TIME: float = 0.5 * 1000
const LUNGE_RECOVERY_TIME: float = 1.0 * 1000
const WAKE_DISTANCE_SQUARED = 96 ** 2
const LUNGE_DISTANCE_SQUARED = 32 ** 2

@onready var state = IdleState.new(self)

func _physics_process(delta):
	var next_state = state._physics_process(delta)
	if next_state:
		state = next_state


class IdleState extends RefCounted:
	var entity: CharacterBody2D
	func _init(entity_):
		entity = entity_
	
	func _physics_process(delta: float):
		if entity.global_position.distance_squared_to(GlobalVars.player.global_position) <= WAKE_DISTANCE_SQUARED:
			return ChaseState.new(entity)


class ChaseState extends RefCounted:
	var entity: CharacterBody2D
	func _init(entity_):
		entity = entity_
	
	func _physics_process(delta: float):
		if entity.global_position.distance_squared_to(GlobalVars.player.global_position) <= LUNGE_DISTANCE_SQUARED:
			return LungeState.new(entity)
		
		var dir_to_player: Vector2 = entity.global_position.direction_to(GlobalVars.player.global_position)
		entity.velocity = dir_to_player * SPEED
		entity.move_and_slide()


class LungeState extends RefCounted:
	var entity: CharacterBody2D
	var direction: Vector2 = Vector2.ZERO
	var start_time = Time.get_ticks_msec()
	
	func _init(entity_):
		entity = entity_
		direction = entity.global_position.direction_to(GlobalVars.player.global_position)
	
	func _physics_process(delta: float):
		if Time.get_ticks_msec() - start_time >= LUNGE_TIME:
			return LungeRecoveryState.new(entity)

		entity.velocity = direction * LUNGE_SPEED
		entity.move_and_slide()

class LungeRecoveryState extends RefCounted:
	var entity: CharacterBody2D
	var start_time = Time.get_ticks_msec()
	
	func _init(entity_):
		entity = entity_
	
	func _physics_process(delta: float):
		if Time.get_ticks_msec() - start_time >= LUNGE_RECOVERY_TIME:
			return IdleState.new(entity)
