extends Control

var difficulty
var grid_size

func receive_data(data):
	var difficulty = data["difficulty"]
	var grid_size = data["grid_size"]
	print("Received Data : " + str(data))

func get_data():
	var data = {}
	data.set("difficulty", difficulty)
	data.set("grid_size", grid_size)
	data.set("campaign", false)
	data.set("level", 0)
	print("sent data: "+str(data))
	return data

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	print("start waiting")
	await wait(20)
	print("finished waiting")
	SceneManager.swap_scenes("res://Scenes/Grid.tscn",get_tree().root,self,"fade_to_black")
