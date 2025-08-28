extends Node2D

var current_scene_instance = null

func _ready() -> void:
	scene_switch("res://Scenes/Menu.tscn", 1)

func scene_switch(scene, difficulty: int):
	if current_scene_instance != null:
		current_scene_instance.queue_free()
	
	var new_scene = load(scene)
	current_scene_instance = new_scene.instantiate()
	
	if scene == "res://Scenes/Ingame_Menu.tscn": 
		current_scene_instance.difficulty = difficulty
	
	add_child(current_scene_instance)
