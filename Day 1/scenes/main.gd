extends Node

var game_began: bool = false

@onready var bird: CharacterBody2D = $Bird

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("flap") and not game_began:
		begin_game()

func begin_game():
	game_began = true
	bird.activate()
