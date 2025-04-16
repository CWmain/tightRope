extends ColorRect

@export var skyColors: Gradient

var dayTimer: float = 0
var direction: int = 1
func _process(delta: float) -> void:
	dayTimer += delta*direction
	color = skyColors.sample(dayTimer/10)
	if dayTimer > 20:
		direction = -1
	if dayTimer < -10:
		direction = 1
	
