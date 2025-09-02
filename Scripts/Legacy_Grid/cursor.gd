extends TileMapLayer
var cursor_pos_1 = 2
var cursor_pos_2 = 2

# func _ready():
signal grid_vertical
signal grid_horizontal


func _process(delta):
	clear()
	set_cell(Vector2i(cursor_pos_1, cursor_pos_2), 1, Vector2i(0, 0))
	# Diffusion on the right
	for n in range(4):
		if cursor_pos_1+n+1 <= 4:
			set_cell(Vector2i(cursor_pos_1+n+1, cursor_pos_2), 1, Vector2i((n+1), 0))
	
	# Diffusion on the left
	for n in range(4):
		if cursor_pos_1-(n+1) >= 0:
			set_cell(Vector2i(cursor_pos_1-(n+1), cursor_pos_2), 1, Vector2i((n+1), 0))
	
	# Diffusion on the bottom
	for n in range(4):
		if cursor_pos_2+n+1 <= 4:
			set_cell(Vector2i(cursor_pos_1, cursor_pos_2+n+1), 1, Vector2i((n+1), 0))
	
	# Diffusion on the left
	for n in range(4):
		if cursor_pos_2-(n+1) >= 0:
			set_cell(Vector2i(cursor_pos_1, cursor_pos_2-(n+1)), 1, Vector2i((n+1), 0))
	
	# Cursor movements	
	if Input.is_action_just_pressed("move_cursor_up"): if cursor_pos_2 > 0: cursor_pos_2 -= 1
	if Input.is_action_just_pressed("move_cursor_down"): if cursor_pos_2 < 4: cursor_pos_2 += 1
	if Input.is_action_just_pressed("move_cursor_left"): if cursor_pos_1 > 0: cursor_pos_1 -= 1
	if Input.is_action_just_pressed("move_cursor_right"): if cursor_pos_1 < 4: cursor_pos_1 += 1
	
	
	# Grid Movements (Only 2 inputs for controller)
	if Input.is_action_just_pressed("move_grid_down"): grid_vertical.emit(cursor_pos_1, "down")
	if Input.is_action_just_pressed("move_grid_right"): grid_horizontal.emit(cursor_pos_2, "right")
	if Input.is_action_just_pressed("move_grid_left"): grid_horizontal.emit(cursor_pos_2, "left")
	if Input.is_action_just_pressed("move_grid_up"): grid_vertical.emit(cursor_pos_1, "up")
