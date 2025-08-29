extends Node2D

var difficulty = 1
signal start_game

func receive_data(data):
	difficulty = data
	print("Received Data : " + str(difficulty))

func _ready():
	print("ready")
	start_game.emit(difficulty)
