extends Control

@onready var menu = $"MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer"
func _on_v_box_container_getout(guide) -> void:
	if guide: SceneManager.swap_scenes("res://Scenes/Guide.tscn",get_tree().root,self,"fade_to_black")
	else: SceneManager.swap_scenes("res://Scenes/Grid.tscn",get_tree().root,self,"fade_to_black")
func get_data():
	var data = {}
	data.set("difficulty", menu.difficulty)
	data.set("grid_size", menu.grid_size)
	data.set("level", 0)
	data.set("campaign", menu.campaign)
	print("sent data from menu: "+str(data))
	return data


func _on_v_box_container_nextmenu() -> void:
	SceneManager.swap_scenes("res://Scenes/MenuPlay.tscn", get_tree().root, self,"fade_to_black")
