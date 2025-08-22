extends TileMapLayer

@onready var title = $"../Control/Label"

func _ready():
	init()
	shuffle(1)

func init():
	# Set numbers so that we get 5 of each shape
	var numbers_available = [5, 5, 5, 5, 5]
	
	# Start Adding the shapes in randomly
	# Each Row
	for n in range(5):
		# Each cell in the row
		for m in range(5):
			var finding_number = true
			var current_number = 0
			# Make sure we don't get more than 5 of each
			while finding_number:
				current_number = randi_range(0, 4)
				if numbers_available[current_number] >= 1:
					numbers_available[current_number] -= 1
					finding_number = false
				
			# print("range: "+str(n) +' '+ str(m))
			# print(str(current_number))
			
			# Put that in the selected cell and the corresponding cell on the other grid
			set_cell(Vector2i(n, m), 1, Vector2i(current_number, 0), 0)
			set_cell(Vector2i(n+7, m), 1, Vector2i(current_number, 0), 0)


func shuffle(dif):
	var shuf_rang = 10
	if dif == 1: shuf_rang = randi_range(3, 15)
	elif dif == 2: shuf_rang = randi_range(15, 25)
	elif dif == 3: shuf_rang = randi_range(25, 50)
	elif dif == 4: shuf_rang = randi_range(50, 100)
	elif dif == 5: shuf_rang = 1
	else: shuf_rang = randi_range(200, 1000)
	print(shuf_rang)
	for i in range(shuf_rang):
		print("looped")
		var direction = randi_range(1, 4)
		print(direction)
		match direction:
			1:
				move_column_down(randi_range(0, 4))
				print("went down")
			2:
				move_column_up(randi_range(0, 4))
				print("went up")
			3:
				move_line_left(randi_range(0, 4), 0)
				print("went left")
			4:
				move_line_right(randi_range(0, 4), 0)
				print("went right")

func move_column_up(col):
	var temp = get_cell_atlas_coords(Vector2i(col, 0))[0]
	set_cell(Vector2i(col, 0), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 1))[0], 0), 0)
	set_cell(Vector2i(col, 1), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 2))[0], 0), 0)
	set_cell(Vector2i(col, 2), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 3))[0], 0), 0)
	set_cell(Vector2i(col, 3), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 4))[0], 0), 0)
	set_cell(Vector2i(col, 4), 1, Vector2i(temp, 0), 0)
	check_squares(0, 0, 7, 0)
	
func move_column_down(col):
	var temp = get_cell_atlas_coords(Vector2i(col, 4))[0]
	set_cell(Vector2i(col, 4), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 3))[0], 0), 0)
	set_cell(Vector2i(col, 3), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 2))[0], 0), 0)
	set_cell(Vector2i(col, 2), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 1))[0], 0), 0)
	set_cell(Vector2i(col, 1), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 0))[0], 0), 0)
	set_cell(Vector2i(col, 0), 1, Vector2i(temp, 0), 0)
	check_squares(0, 0, 7, 0)
	
func move_line_left(line, relcol):
	var temp = get_cell_atlas_coords(Vector2i(relcol+0, line))[0]
	set_cell(Vector2i(relcol+0, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+1, line))[0], 0), 0)
	set_cell(Vector2i(relcol+1, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+2, line))[0], 0), 0)
	set_cell(Vector2i(relcol+2, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+3, line))[0], 0), 0)
	set_cell(Vector2i(relcol+3, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+4, line))[0], 0), 0)
	set_cell(Vector2i(relcol+4, line), 1, Vector2i(temp, 0), 0)
	check_squares(0, 0, 7, 0)
	
func move_line_right(line, relcol):
	var temp = get_cell_atlas_coords(Vector2i(relcol+4, line))[0]	
	set_cell(Vector2i(relcol+4, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+3, line))[0], 0), 0)
	set_cell(Vector2i(relcol+3, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+2, line))[0], 0), 0)
	set_cell(Vector2i(relcol+2, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+1, line))[0], 0), 0)
	set_cell(Vector2i(relcol+1, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+0, line))[0], 0), 0)
	set_cell(Vector2i(relcol+0, line), 1, Vector2i(temp, 0), 0)
	check_squares(0, 0, 7, 0)
	
func check_squares(originn, origino, n1, o1):
	var win = true
	for n in range(5):
		for o in range(5):
			var square1 = get_cell_atlas_coords(Vector2i(n1+n, o1+o))
			var square2 = get_cell_atlas_coords(Vector2i(originn+n, origino+o))
			if not square1[0] == square2[0]:
				print(str(square1)+str(square2))
				win = false
	if win == true: title.text = "You WIN !"
		
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_move_grid_horizontal(pos, dir) -> void:
	if dir == "right": move_line_right(pos, 0)
	if dir == "left": move_line_left(pos, 0)
	wait(1)


func _on_move_grid_vertical(pos, dir) -> void:
	if dir == "down": move_column_down(pos)
	if dir == "up": move_column_up(pos)
	
