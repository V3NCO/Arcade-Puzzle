extends Node2D

# Shuffle steps : 1 to 5
# 1 - 3-15 Shuffle Steps
# 2 - 15-25 Shuffle Steps
# 3 - 25-50 Shuffle Steps
# 4 - 50-100 Shuffle Steps
# 5 - 200-1000 Shuffle Steps
var difficulty = 1
# Grid Sizes : 3x3 5x5 7x7 9x9 12x12 15x15
var grid_size = 5
# Each Panels
@onready var right_panel = $%RightPanel
@onready var left_panel = $%LeftPanel

func _ready() -> void:
	start()

func start():
	# Makes the list of still available numbers for shuffle
	var num_available = []
	num_available.resize(grid_size)
	num_available.fill(grid_size)
	
	var initial_grid = {}
	
	for n in range(grid_size):
		var grid_line = []
		for m in range(grid_size):
			var finding_number = true
			var current_number = 0
			while finding_number:
				current_number = randi_range(0, grid_size-1)
				if num_available[current_number] >= 1:
					num_available[current_number] -= 1
					finding_number = false
			grid_line.append(current_number)
		initial_grid.set(n, grid_line)
	print("Initial grid should be done, here it is : "+str(initial_grid))
	print("Step 1 complete; Proceeding to Step 2.")
	var cell_size = float(630)/grid_size
	# TODO: Create objects at position cell_size*grid_position
	# Maybe make the shuffle internal to the grid directly from the Dictionary
	# I can use "clipping" to have that mask effect where you dont see OOB stuff
	# Everything will have to be fast, dynamic and smooth; even the cursor; maybe ease in/out fast would be good
	# Find a way to scale the asset to the sprite or whatever you choose
	
