extends Node

var current_screen: Node = null

func _ready() -> void:
	scene_switch("res://Scenes/Menu.tscn", 1, false)

func scene_switch(path: String, difficulty: int, pass_diff: bool) -> void:
	# Remove previous screen if any
	if is_instance_valid(current_screen):
		current_screen.queue_free()
		current_screen = null
	
	# Load and add the new screen
	var packed := load(path)
	if packed == null:
		push_error("SceneManager: Failed to load %s" % path)
		return

	current_screen = packed.instantiate()
	if pass_diff:
		print(difficulty) 
		current_screen.difficulty = difficulty
	add_child(current_screen)

	# Pass data to the new scene (Ingame_Menu.gd defines `var difficulty = 1`, so this is safe)


func scene_transition(path: String, difficulty: int, pass_diff: bool) -> void:
	# Remove previous screen if any
	if is_instance_valid(current_screen):
		current_screen.queue_free()
		current_screen = null
	
	# Load and add the new screen
	var packed := load(path)
	if packed == null:
		push_error("SceneManager: Failed to load %s" % path)
		return

	current_screen = packed.instantiate()
	if pass_diff:
		print(difficulty) 
		current_screen.difficulty = difficulty
	add_child(current_screen)

	# Pass data to the new scene (Ingame_Menu.gd defines `var difficulty = 1`, so this is safe)
