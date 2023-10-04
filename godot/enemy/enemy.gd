extends CharacterBody2D

const SPEED: float = 48.0
const LUNGE_SPEED: float = 128.0
const LUNGE_WIND_UP_TIME: float = 0.25 * 1000
const LUNGE_TIME: float = 0.5 * 1000
const LUNGE_RECOVERY_TIME: float = 1.0 * 1000
const WAKE_DISTANCE_SQUARED: float = 96.0 ** 2
const LUNGE_DISTANCE_SQUARED: float = 32.0 ** 2

@onready var anim = $HumanoidAnimations
@onready var state = IdleState.new(self)


enum {FACE_RIGHT, FACE_LEFT}
var facing = FACE_RIGHT

func _ready():
	Cutscene.cutscene_started.connect(_on_Cutscene_cutscene_started)

func _on_Cutscene_cutscene_started():
	stand()

func stand():
	if facing == FACE_RIGHT:
		anim.play("stand_right")
	else:
		anim.play("stand_left")

func walk():
	if facing == FACE_RIGHT:
		anim.play("walk_right")
	else:
		anim.play("walk_left")

func face_player():
	if global_position.direction_to(GlobalVars.player.global_position).x > 0:
		facing = FACE_RIGHT
	elif global_position.direction_to(GlobalVars.player.global_position).x < 0:
		facing = FACE_LEFT

func hitbox_enabled(enable: bool):
	$HitBox/CollisionShape2D.disabled = not enable

func _physics_process(delta):
	if Cutscene.state != Cutscene.IDLE:
		return
	var next_state = state._physics_process(delta)
	if next_state:
		state = next_state


class IdleState extends RefCounted:
	var entity: CharacterBody2D
	func _init(entity_):
		entity = entity_
		entity.stand()
		entity.hitbox_enabled(false)
	
	func _physics_process(delta: float):
		if entity.global_position.distance_squared_to(GlobalVars.player.global_position) <= WAKE_DISTANCE_SQUARED:
			return ChaseState.new(entity)


class ChaseState extends RefCounted:
	var entity: CharacterBody2D
	func _init(entity_):
		entity = entity_
	
	func _physics_process(delta: float):
		entity.face_player()
		entity.walk()
		if entity.global_position.distance_squared_to(GlobalVars.player.global_position) <= LUNGE_DISTANCE_SQUARED:
			return LungeWindUpState.new(entity)
		
		var dir_to_player: Vector2 = entity.global_position.direction_to(GlobalVars.player.global_position)
		entity.velocity = dir_to_player * SPEED
		entity.move_and_slide()


class LungeWindUpState extends RefCounted:
	var entity: CharacterBody2D
	var start_time = Time.get_ticks_msec()
	
	func _init(entity_):
		entity = entity_
		entity.face_player()
		entity.stand()

	
	func _physics_process(delta: float):
		if Time.get_ticks_msec() - start_time >= LUNGE_WIND_UP_TIME:
			return LungeState.new(entity)


class LungeState extends RefCounted:
	var entity: CharacterBody2D
	var direction: Vector2 = Vector2.ZERO
	var start_time = Time.get_ticks_msec()
	
	func _init(entity_):
		entity = entity_
		entity.face_player()
		entity.walk()
		direction = entity.global_position.direction_to(GlobalVars.player.global_position)
		entity.hitbox_enabled(true)
	
	func _physics_process(delta: float):
		entity.walk()
		if Time.get_ticks_msec() - start_time >= LUNGE_TIME:
			return LungeRecoveryState.new(entity)

		entity.velocity = direction * LUNGE_SPEED
		entity.move_and_collide(entity.velocity * delta)

class LungeRecoveryState extends RefCounted:
	var entity: CharacterBody2D
	var start_time = Time.get_ticks_msec()
	
	func _init(entity_):
		entity = entity_
		entity.stand()
		entity.hitbox_enabled(false)
	
	func _physics_process(delta: float):
		if Time.get_ticks_msec() - start_time >= LUNGE_RECOVERY_TIME:
			return IdleState.new(entity)
