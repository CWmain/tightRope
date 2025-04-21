@tool
extends Node2D
class_name PointsDisplay


@export var digit: PackedScene
@export var digitSpacing: float = 32.0
@export var value: int:
	set(a):
		value = a
		updateScore()
		
@export var paused: bool = true:
	set(value):
		paused = value
		if paused:
			pauseAnimation()
		else:
			playAnimation()

# Given a number we need to find each value
# This can be done by % 10, then select the corresponding image and place on screen

func pauseAnimation() -> void:
	for child: AnimatedSprite2D in get_children():
		child.speed_scale = 0
		
func playAnimation() -> void:
	for child: AnimatedSprite2D in get_children():
		child.speed_scale = 1

func updateScore()->void:
	#Delete all old children
	for child in get_children():
		child.queue_free()
		
	var targetNumber: int = value
	var offset = 0
	while targetNumber >= 10:
		var newDigit: DrawnNumber = digit.instantiate()
		newDigit.set_number(targetNumber%10)
		if paused:
			newDigit.speed_scale = 0
		newDigit.position.x = offset
		add_child(newDigit)
		offset -= digitSpacing
		targetNumber /= 10

	var newDigit = digit.instantiate()
	newDigit.set_number(targetNumber%10)
	if paused:
		newDigit.speed_scale = 0
	newDigit.position.x = offset
	add_child(newDigit)
