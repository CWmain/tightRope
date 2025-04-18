extends Sprite2D
class_name DrawnNumber
	
func set_number(num: int) -> void:
	if num > 9 || num < 0:
		return
	texture.region = Rect2(num*32, 0, 32, 32)
	
