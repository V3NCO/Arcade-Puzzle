extends Node2D

var difficulty = 1
signal start_game

func _ready():
	print("ready")
	start_game.emit(difficulty)
