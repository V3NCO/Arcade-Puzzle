extends Node2D

# Shuffle steps : 1 to 5
# 1 - 3-15 Shuffle Steps
# 2 - 15-25 Shuffle Steps
# 3 - 25-50 Shuffle Steps
# 4 - 50-100 Shuffle Steps
# 5 - 200-1000 Shuffle Steps
var difficulty = 5
# Grid Sizes : 3x3 5x5 7x7 9x9 12x12
var grid_size = 12
# Each Panels
@onready var right_panel = $%RightPanel
@onready var left_panel = $%LeftPanel
signal init_done

func _ready() -> void:
	start()

func start():
	# Make initial Grid
	var initial_grid = init_make_grid(grid_size)
	
	# Debug Text
	print("Initial grid should be done, here it is : "+str(initial_grid))
	print("Step 1 complete; Proceeding to Step 2.")
	
	# Set the size for each cell to fit in the grid
	var cell_size = float(630)/grid_size
	init_render_cells(initial_grid, cell_size, "CellRight", right_panel)
	print("Step 2 complete; Proceeding to Step 3.")
	init_render_cells(scramble_grid(initial_grid, difficulty), cell_size, "CellLeft", left_panel)
	print("Step 3 Complete. Sending Data to Left Panel.")
	init_done.emit(difficulty, grid_size, cell_size)

# Scrambly Scrambly and Create Initial grid
func init_make_grid(grid_size: int):
	# Initialize grid value
	var initial_grid = {}
	
	# This will store the available numbers so that the distribution is even
	var num_available = []
	num_available.resize(grid_size)
	num_available.fill(grid_size)
	
	# Loops through the lines
	for n in range(grid_size):
		# Initialize value for this specific line
		var grid_line = []
		
		# For each number in the line make sure that it can be used so that the distribution is even
		for m in range(grid_size):
			var finding_number = true
			var current_number = 0
			while finding_number:
				current_number = randi_range(0, grid_size-1)
				if num_available[current_number] >= 1:
					num_available[current_number] -= 1
					finding_number = false
			# Add Number to line
			grid_line.append(current_number)
		# Add line to grid
		initial_grid.set(n, grid_line)
	# This is self explanatory
	return initial_grid


# Scramble the grid :3
func scramble_grid(initial_grid, difficulty):
	# Gives the number of moves for the shuffle based on difficulty
	var shuf_num = 10
	if difficulty == 1: shuf_num = randi_range(3, 15)
	elif difficulty == 2: shuf_num = randi_range(15, 25)
	elif difficulty == 3: shuf_num = randi_range(25, 50)
	elif difficulty == 4: shuf_num = randi_range(50, 100)
	elif difficulty == 100: shuf_num = 1
	else: shuf_num = randi_range(200, 1000)
	
	# Debug text
	print("Difficulty is at "+str(difficulty)+", Picked "+str(shuf_num)+" Moves in shuffle process")
	var new_grid = initial_grid
	for i in range(shuf_num):
		var direction = randi_range(1, 4)
		match direction:		
			1: # Down
				# Set Values
				var last_line = new_grid.size()-1
				var column = randi_range(0, last_line)
				var temp = new_grid[last_line][column]
				
				# Debug Text
				# print("Going down on column "+str(column))
				
				# Go Down gng
				for k in range(new_grid.size()):
					if k != last_line:
						new_grid[last_line-(k)][column] = new_grid[last_line-(k+1)][column]
					else:
						new_grid[0][column] = temp
			2: # Up
				# Set Values
				var last_line = new_grid.size()-1
				var column = randi_range(0, last_line)
				var temp = new_grid[0][column]
				
				# Debug Text
				# print("Going up on column "+str(column))
				
				# Go Up gng
				for k in range(new_grid.size()):
					if k != last_line:
						new_grid[k][column] = new_grid[k+1][column]
					else:
						new_grid[last_line][column] = temp
			3: # Left
				# Set Values
				var last_col = new_grid.size()-1
				var line = randi_range(0, last_col)
				var temp = new_grid[line][0]
				
				# Debug Text
				# print("Going left on line "+str(line))
				
				# Go left gng
				for k in range(new_grid[line].size()):
					if k != last_col:
						new_grid[line][k] = new_grid[line][k+1]
					else:
						new_grid[line][last_col] = temp
				
			4: # Right
				# Set Values
				var last_col = new_grid.size()-1
				var line = randi_range(0, last_col)
				var temp = new_grid[line][last_col]
				
				# Debug Text
				# print("Going right on line "+str(line))
				
				# Go right gng
				for k in range(new_grid[line].size()):
					if k != last_col:
						new_grid[line][last_col-(k)] = new_grid[line][last_col-(k+1)]
					else:
						new_grid[line][0] = temp
	print("New Grid is : "+str(new_grid))
	return new_grid




# Render Cells
func init_render_cells(initial_grid: Dictionary, cell_size: float, cells_name: String, add_to):
	for n in initial_grid:
		var index = 0
		for o in initial_grid[n]:
			# Set some variables
			var text_str = "res://assets/images/Tiles/Compo"+str(o+1)+".png"
			var cell = Sprite2D.new()
			var scale_fact = float(cell_size) / 196
			
			# Set position, texture, size, name, and make it not centered; we manage that ourselves
			cell.position = Vector2(cell_size*index, cell_size*n)		
			cell.texture = load(text_str)
			cell.scale = Vector2(scale_fact, scale_fact)
			cell.centered = false
			cell.name = "Cell_"+str(index)+"_"+str(n)+"_"+str(o+1)
			# n is line; index is column; o is the texture id (-1)
			# Debug Text
			# print("Setting Cell Named "+str(cell.name)+" that has "+str(text_str)+" set as their texture and "+str(scale_fact)+" as their scale at : " + str(Vector2(cell_size*index, cell_size*n)))			
			
			# Make Cell
			cell.set_name(cells_name+"_"+str(index)+"_"+str(n)+"_"+str(o+1))
			add_to.add_child(cell)
			
			# Add one to index bcz idk how to make it so I can get the index from o directly :P
			index += 1
			
			
			
	# I can use "clipping" to have that mask effect where you dont see OOB stuff
	# Everything will have to be fast, dynamic and smooth; even the cursor; maybe ease in/out fast would be good
	# Find a way to scale the asset to the sprite or whatever you choose
	
