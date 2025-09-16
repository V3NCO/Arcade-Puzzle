extends Control

var difficulty
var grid_size
var dataa

func receive_data(data):
	var difficulty = data["difficulty"]
	var grid_size = data["grid_size"]
	dataa = data
	print("Received Data : " + str(data))

func get_data():
	print("sent data: "+str(dataa))
	return dataa

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	print("start waiting")
	await wait(20)
	print("finished waiting")
	SceneManager.swap_scenes("res://Scenes/Grid.tscn",get_tree().root,self,"fade_to_black")
