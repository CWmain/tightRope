@tool
extends Node2D
class_name PointsDisplay


@export var number: PackedScene
@export var value: int:
	set(a):
		value = a
		updateScore()
		

# Given a number we need to find each value
# This can be done by % 10, then select the corresponding image and place on screen

func updateScore()->void:
	#Delete all old children
	for child in get_children():
		child.queue_free()
		
	var targetNumber: int = value
	var offset = 0
	while targetNumber >= 10:
		var newNumber: DrawnNumber = number.instantiate()
		newNumber.texture = newNumber.texture.duplicate()
		newNumber.set_number(targetNumber%10)
		newNumber.position.x = offset
		add_child(newNumber)
		offset -= 32
		targetNumber /= 10

	var newNumber = number.instantiate()
	newNumber.set_number(targetNumber%10)
	newNumber.position.x = offset
	add_child(newNumber)
