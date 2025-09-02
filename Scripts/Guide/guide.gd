extends Control

var difficulty

func receive_data(data):
	var difficulty = data
	print("Received Data : " + str(difficulty))

func get_data():
	var data = difficulty
	print("sent data: "+str(data))
	return data

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
func _ready() -> void:
	print("start waiting")
	await wait(20)
	print("finished waiting")
	SceneManager.swap_scenes("res://Scenes/Grid.tscn",get_tree().root,self,"fade_to_black")
