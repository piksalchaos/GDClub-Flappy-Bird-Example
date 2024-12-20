extends CharacterBody2D

const START_POSITION: Vector2 = Vector2(240, 360)
const GRAVITY: float = 1100.0
const JUMP_VELOCITY: float = -500.0
const MIN_Y_POSITION: float = -50.0
const VELOCITY_TO_DEGREES_RATIO: float = 0.05

var is_active: bool = false
var is_flying: bool = true

@onready var flap_audio: AudioStreamPlayer = $FlapAudio

func _ready():
	position = START_POSITION

func _physics_process(delta: float) -> void:
	if not is_active:
		return
	velocity.y += GRAVITY * delta
	if is_flying:
		set_rotation_degrees(velocity.y * VELOCITY_TO_DEGREES_RATIO)
		if position.y < MIN_Y_POSITION:
			position.y = MIN_Y_POSITION
			velocity.y = 0
	move_and_slide()

func _input(event: InputEvent) -> void:
	if not is_active:
		return
	if is_flying and event.is_action_pressed("flap"):
		flap_audio.play()
		velocity.y = JUMP_VELOCITY

func hit():
	is_flying = false
	velocity.y = 0
	set_rotation_degrees(90)

func activate():
	flap_audio.play()
	is_active = true
	velocity.y = JUMP_VELOCITY
