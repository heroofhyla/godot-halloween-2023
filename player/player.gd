extends CharacterBody2D

const SPEED = 64.0

enum {FACE_RIGHT, FACE_LEFT}
var facing = FACE_RIGHT

var interactables: Array = []

func _ready():
	$InteractableDetector.area_entered.connect(_on_InteractableDetector_area_entered)
	$InteractableDetector.area_exited.connect(_on_InteractableDetector_area_exited)
	Cutscene.cutscene_started.connect(_on_Cutscene_cutscene_started)

func _on_Cutscene_cutscene_started():
	if facing == FACE_RIGHT:
		$AnimatedSprite2D.play("stand_right")
	else:
		$AnimatedSprite2D.play("stand_left")
func cleanup_interactables():
	for ii in range(interactables.size() - 1, -1, -1):
			var interactable = interactables[ii]
			if not is_instance_valid(interactable):
				interactables.remove_at(ii)

func _on_InteractableDetector_area_entered(area: Area2D):
	cleanup_interactables()
	if area is Interactable:
		interactables.push_back(area)
		EventBus.top_interactable_changed.emit(area)

func _on_InteractableDetector_area_exited(area: Area2D):
	cleanup_interactables()
	while area in interactables:
		interactables.erase(area)
	if interactables:
		EventBus.top_interactable_changed.emit(interactables.back())
	else:
		EventBus.top_interactable_changed.emit(null)

func _input(event):
	if Cutscene.state != Cutscene.IDLE:
		return
	if event.is_action_pressed("interact"):
		if interactables:
			interactables.back().interact()
			get_viewport().set_input_as_handled()

func _physics_process(_delta):
	if Cutscene.state != Cutscene.IDLE:
		return
	var input_vector = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_vector.x += 1
	if Input.is_action_pressed("move_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("move_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("move_down"):
		input_vector.y += 1
	
	if input_vector.x > 0:
		facing = FACE_RIGHT
	if input_vector.x < 0:
		facing = FACE_LEFT
	
	if input_vector:
		if facing == FACE_RIGHT:
			$AnimatedSprite2D.play("walk_right")
		else:
			$AnimatedSprite2D.play("walk_left")
		input_vector = input_vector.normalized()
		velocity = input_vector * SPEED
		move_and_slide()
	else:
		if facing == FACE_RIGHT:
			$AnimatedSprite2D.play("stand_right")
		else:
			$AnimatedSprite2D.play("stand_left")
