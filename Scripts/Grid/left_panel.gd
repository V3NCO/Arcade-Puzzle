extends Panel

var init_done = false
var difficulty
var grid_size
var case_size


func _on_init_done(diff, gs, cs) -> void:
	difficulty = diff
	grid_size = gs
	case_size = cs
	init_cursor()
	init_done = true

func init_cursor():
	if grid_size == 3:
		var posx = case_size*2.5
		var posy = case_size*2.5
		
		
func cursor_move(direction):
	# if direction == "right":
	pass
