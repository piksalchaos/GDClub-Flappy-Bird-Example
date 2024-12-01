extends Node

const PIPE_SCENE: PackedScene = preload("res://scenes/pipe.tscn")
const PIPE_Y_RANGE: int = 400
const PIPE_X_OFFSET: int = 50
const SCROLL_SPEED: float = 200

var game_began: bool = false
var pipes: Array
var score: int = 0

@onready var screen_size: Vector2i = get_window().size

@onready var bird: CharacterBody2D = $Bird
@onready var pipe_timer: Timer = $PipeTimer
@onready var score_audio: AudioStreamPlayer = $ScoreAudio

func _process(delta: float) -> void:
	if not game_began:
		return
	for i in range(pipes.size()):
		pipes[i].position.x -= SCROLL_SPEED * delta
		if pipes[i].position.x < -PIPE_X_OFFSET:
			pipes[i].queue_free()
			pipes.pop_back()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flap") and not game_began:
		begin_game()

func begin_game():
	game_began = true
	bird.activate()
	pipe_timer.start()

func _on_pipe_timer_timeout() -> void:
	var pipe = PIPE_SCENE.instantiate()
	pipe.position.x = screen_size.x + PIPE_X_OFFSET
	pipe.position.y = (screen_size.y + randi_range(-PIPE_Y_RANGE, PIPE_Y_RANGE))/2.0
	pipe.scored.connect(score_point)
	add_child(pipe)
	pipes.insert(0, pipe)

func score_point():
	score_audio.play()
	score += 1
	print(score)
