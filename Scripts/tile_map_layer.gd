extends TileMapLayer


func _ready():
	init()

func init():
	var numbers_available = [5, 5, 5, 5, 5]
	for n in range(5):
		for m in range(5):
			var finding_number = true
			var current_number = 0
			while finding_number:
				current_number = randi_range(0, 4)
				if numbers_available[current_number] >= 1:
					numbers_available[current_number] -= 1
					finding_number = false
				
			print("range: "+str(n) +' '+ str(m))
			print(str(current_number))
			set_cell(Vector2i(n, m), 1, Vector2i(current_number, 0), 0)
			set_cell(Vector2i(n+7, m), 1, Vector2i(current_number, 0), 0)
