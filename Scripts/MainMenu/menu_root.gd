extends Control

@onready var menu = $%VBoxContainer
func _on_v_box_container_getout(guide) -> void:
	if guide: SceneManager.swap_scenes("res://Scenes/Guide.tscn",get_tree().root,self,"fade_to_black")
	else: SceneManager.swap_scenes("res://Scenes/Grid.tscn",get_tree().root,self,"fade_to_black")
func get_data():
	var data = menu.difficulty
	print("sent data: "+str(data))
	return data
