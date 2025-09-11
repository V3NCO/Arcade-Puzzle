extends Panel

var init_done = false
var difficulty; var grid_size; var cell_size; var initial_grid
var cursor; var cursor_tween: Tween
var current_grid_x: int; var current_grid_y: int; 
var grid_tween: Tween
@onready var right_grid = $%RightPanel

func _on_init_done(diff, gs, cs) -> void:
	difficulty = diff
	grid_size = gs
	cell_size = cs
	print("Data Received and Values set difficulty : "+str(difficulty)+"; grid_size: "+str(grid_size)+"; cell_size: "+str(cell_size))
	init_cursor()
	initial_grid = {}
	for i in range(grid_size):
		var current_line = []
		
		for j in range(grid_size):
			var current_coords = Vector2(cell_size*j, cell_size*i)
			for child in right_grid.get_children():
				if child is Sprite2D and child.name != "Cursor":
					if child.position == current_coords:
						current_line.append(int(child.texture.resource_path.trim_suffix(".png").trim_prefix("res://assets/images/Tiles/Compo")))
		initial_grid.set(i, current_line)
	init_done = true

func init_cursor():
	print("Now initializing cursor")
	cursor = Sprite2D.new()
	var posx; var posy; var scalee
	if grid_size == 3: print("CURSOR_DEBUG: Grid Size is 3x3"); posx = cell_size*1.5; posy = cell_size*1.5; scalee = Vector2(1.20, 1.20)
	if grid_size == 5: print("CURSOR_DEBUG: Grid Size is 5x5"); posx = cell_size*2.5; posy = cell_size*2.5; scalee = Vector2(0.7, 0.7)
	if grid_size == 7: print("CURSOR_DEBUG: Grid Size is 7x7"); posx = cell_size*3.5; posy = cell_size*3.5; scalee = Vector2(0.5, 0.5)
	if grid_size == 9: print("CURSOR_DEBUG: Grid Size is 9x9"); posx = cell_size*4.5; posy = cell_size*4.5; scalee = Vector2(0.4, 0.4)
	# Ah yes I love making grid sizes where there is no center :pf:
	if grid_size == 12: print("CURSOR_DEBUG: Grid Size is 12x12"); posx = cell_size*6.5; posy = cell_size*6.5; scalee = Vector2(0.3, 0.3)

	cursor.texture = preload("res://assets/images/Cursors/Cursor.svg")
	cursor.position = Vector2(posx, posy)
	cursor.centered = true
	cursor.name = "Cursor"
	cursor.scale = Vector2(scalee)
	
	add_child(cursor)
	move_child(cursor, 0)
	cursor_tween = create_tween()
	cursor_tween.set_trans(Tween.TRANS_CUBIC)
	cursor_tween.set_ease(Tween.EASE_IN_OUT)
	grid_tween = create_tween()
	current_grid_x = grid_size / 2; current_grid_y = grid_size / 2
		
func cursor_move(direction):
	var new_x = current_grid_x
	var new_y = current_grid_y
	
	if direction == "right" and current_grid_x < grid_size - 1:
		new_x += 1
	elif direction == "left" and current_grid_x > 0:
		new_x -= 1
	elif direction == "down" and current_grid_y < grid_size - 1:
		new_y += 1
	elif direction == "up" and current_grid_y > 0:
		new_y -= 1
	
	if new_x != current_grid_x or new_y != current_grid_y:
		current_grid_x = new_x
		current_grid_y = new_y
		
		var target_pos = Vector2((new_x + 0.5) * cell_size, (new_y + 0.5) * cell_size)
		
		cursor_tween.kill()
		cursor_tween = create_tween()
		cursor_tween.set_trans(Tween.TRANS_CUBIC)
		cursor_tween.set_ease(Tween.EASE_IN_OUT)
		cursor_tween.tween_property(cursor, "position", target_pos, 0.05)

func grid_move(direction):
	var cells_to_move = []
	
	if grid_tween.is_valid():
		grid_tween.custom_step(999)
		grid_tween.kill()
	
	if direction == "down" or direction == "up":
		for child in get_children():
			if child is Sprite2D and child.name != "Cursor":
				if child.position.x == cell_size * current_grid_x:
					cells_to_move.append(child)
	
	elif direction == "left" or direction == "right":
		for child in get_children():
			if child is Sprite2D and child.name != "Cursor":
				if child.position.y == cell_size * current_grid_y:
					cells_to_move.append(child)
	
	grid_tween = create_tween()
	grid_tween.set_parallel(true)
	grid_tween.set_trans(Tween.TRANS_CUBIC)
	grid_tween.set_ease(Tween.EASE_IN_OUT)
	
	for cell in cells_to_move:
		var start_pos = cell.position
		var end_pos = start_pos
		
		match direction:
			"up":
				if not start_pos.y == 0:
					end_pos.y -= cell_size
					grid_tween.tween_property(cell, "position", end_pos, 0.10)
				else:
					var newcell = cell.duplicate()
					newcell.position = Vector2(start_pos.x, 630)
					add_child(newcell)
					grid_tween.tween_property(newcell, "position", Vector2(start_pos.x, 630 - cell_size), 0.10)
					cell.call_deferred("queue_free")
			"down":
				if not start_pos.y == 630.0-cell_size:
					end_pos.y += cell_size
					grid_tween.tween_property(cell, "position", end_pos, 0.10)
				else:
					var newcell = cell.duplicate()
					newcell.position = Vector2(start_pos.x, -cell_size)
					add_child(newcell)
					grid_tween.tween_property(newcell, "position", Vector2(start_pos.x, 0), 0.10)
					cell.call_deferred("queue_free")
			"left":
				if not start_pos.x == 0:
					end_pos.x -= cell_size
					grid_tween.tween_property(cell, "position", end_pos, 0.10)
				else:
					var newcell = cell.duplicate()
					newcell.position = Vector2(630, start_pos.y)
					add_child(newcell)
					grid_tween.tween_property(newcell, "position", Vector2(630 - cell_size, start_pos.y), 0.10)
					cell.call_deferred("queue_free")
			"right":
				if not start_pos.x == 630.0-cell_size:
					end_pos.x += cell_size
					grid_tween.tween_property(cell, "position", end_pos, 0.10)
				else:
					var newcell = cell.duplicate()
					newcell.position = Vector2(-cell_size, start_pos.y)
					add_child(newcell)
					grid_tween.tween_property(newcell, "position", Vector2(0, start_pos.y), 0.10)
					cell.call_deferred("queue_free")

func check_win():
	var texture_list = {}
	for i in range(grid_size):
		var current_line = []
		
		for j in range(grid_size):
			var current_coords = Vector2(cell_size*j, cell_size*i)
			for child in get_children():
				if child is Sprite2D and child.name != "Cursor":
					if child.position == current_coords:
						current_line.append(int(child.texture.resource_path.trim_suffix(".png").trim_prefix("res://assets/images/Tiles/Compo")))
		texture_list.set(i, current_line)
	if init_done:
		if texture_list == initial_grid:
			won()

func won():
	print("Won !")
	init_done = false

func _process(_delta):
	if Input.is_action_just_pressed("move_cursor_up"): cursor_move("up")
	if Input.is_action_just_pressed("move_cursor_down"): cursor_move("down")
	if Input.is_action_just_pressed("move_cursor_left"): cursor_move("left")
	if Input.is_action_just_pressed("move_cursor_right"): cursor_move("right")
	
	if Input.is_action_just_pressed("move_grid_down"): grid_move("down")
	if Input.is_action_just_pressed("move_grid_right"): grid_move("right")
	if Input.is_action_just_pressed("move_grid_left"): grid_move("left")
	if Input.is_action_just_pressed("move_grid_up"): grid_move("up")
	check_win()
