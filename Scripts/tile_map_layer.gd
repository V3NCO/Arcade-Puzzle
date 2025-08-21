extends TileMapLayer


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


func shuffle(dif: int):
	var shuf_rang = 10
	match dif:
		_:
			shuf_rang = randi_range(200, 1000)
		1:
			shuf_rang = randi_range(3, 15)
		2:
			shuf_rang = randi_range(15, 25)
		3:
			shuf_rang = randi_range(25, 50)
		4:
			shuf_rang = randi_range(50, 100)
	
	for i in range(shuf_rang):
		var direction = randi_range(1, 4)
		match direction:
			1:
				move_column_down(randi_range(0, 4))
			2:
				move_column_up(randi_range(0, 4))
			3:
				move_line_left(randi_range(0, 4), 0)
			4:
				move_line_right(randi_range(0, 4), 0)

func move_column_up(col):
	var temp = get_cell_atlas_coords(Vector2i(col, 0))[0]
	set_cell(Vector2i(col, 0), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 1))[0], 0), 0)
	set_cell(Vector2i(col, 1), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 2))[0], 0), 0)
	set_cell(Vector2i(col, 2), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 3))[0], 0), 0)
	set_cell(Vector2i(col, 3), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 4))[0], 0), 0)
	set_cell(Vector2i(col, 4), 1, Vector2i(temp, 0), 0)
	
func move_column_down(col):
	var temp = get_cell_atlas_coords(Vector2i(col, 4))[0]
	set_cell(Vector2i(col, 4), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 3))[0], 0), 0)
	set_cell(Vector2i(col, 3), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 2))[0], 0), 0)
	set_cell(Vector2i(col, 2), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 1))[0], 0), 0)
	set_cell(Vector2i(col, 1), 1, Vector2i(get_cell_atlas_coords(Vector2i(col, 0))[0], 0), 0)
	set_cell(Vector2i(col, 0), 1, Vector2i(temp, 0), 0)

func move_line_left(line, relcol):
	var temp = get_cell_atlas_coords(Vector2i(relcol+0, line))[0]
	set_cell(Vector2i(relcol+0, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+1, line))[0], 0), 0)
	set_cell(Vector2i(relcol+1, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+2, line))[0], 0), 0)
	set_cell(Vector2i(relcol+2, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+3, line))[0], 0), 0)
	set_cell(Vector2i(relcol+3, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+4, line))[0], 0), 0)
	set_cell(Vector2i(relcol+4, line), 1, Vector2i(temp, 0), 0)
	
func move_line_right(line, relcol):
	var temp = get_cell_atlas_coords(Vector2i(relcol+4, line))[0]	
	set_cell(Vector2i(relcol+4, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+3, line))[0], 0), 0)
	set_cell(Vector2i(relcol+3, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+2, line))[0], 0), 0)
	set_cell(Vector2i(relcol+2, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+1, line))[0], 0), 0)
	set_cell(Vector2i(relcol+1, line), 1, Vector2i(get_cell_atlas_coords(Vector2i(relcol+0, line))[0], 0), 0)
	set_cell(Vector2i(relcol+0, line), 1, Vector2i(temp, 0), 0)
