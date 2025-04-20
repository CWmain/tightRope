@tool
extends AnimatedSprite2D
class_name DrawnNumber
	
func set_number(num: int) -> void:
	if num > 9 || num < 0:
		printerr("Attempting to print an invalid digit, returning 0")
		return
	play(str(num))
