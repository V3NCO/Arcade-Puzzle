extends VBoxContainer


var difficulty = 1
@onready var diff_btn = $DifficultyBtn/Label
signal ask_start
signal getout

func _ready():
	diff_btn.text = "Difficulty : 1 - 3-15 Shuffle Steps"



func _on_difficulty_pressed() -> void:
	if difficulty < 5:
		difficulty += 1
	else: difficulty = 1
	if difficulty == 1:
		diff_btn.text = "Difficulty : 1 - 3-15 Shuffle Steps"
	elif difficulty == 2:
		diff_btn.text = "Difficulty : 2 - 15-25 Shuffle Steps"
	elif difficulty == 3:
		diff_btn.text = "Difficulty : 3 - 25-50 Shuffle Steps"
	elif difficulty == 4:
		diff_btn.text = "Difficulty : 4 - 50-100 Shuffle Steps"
	elif difficulty == 5:
		diff_btn.text = "Difficulty : 5 - 200-1000 Shuffle Steps"


func _on_play_button_pressed() -> void:
	# SceneManager.scene_switch("res://Scenes/Ingame_Menu.tscn", difficulty, true)
	# Only do this if your SceneManager isn't using change_scene_to_file right away.
	getout.emit(true)

func _quit_button() -> void:
	get_tree().quit()


func _on_skip_button_pressed() -> void:
	getout.emit(false)
