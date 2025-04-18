extends Node2D

@export var gm: GameManager
@export var number: PackedScene
#Given a number we need to find each value
# This can be done by % 10, then select the corresponding image and place on screen

func _ready() -> void:
	gm.newScore.connect(updateScore)

func updateScore()->void:
	#Delete all old children
	for child in get_children():
		child.queue_free()
		
	var currentPoints: int = gm.points
	var offset = 0
	while currentPoints >= 10:
		var newNumber: DrawnNumber = number.instantiate()
		newNumber.texture = newNumber.texture.duplicate()
		newNumber.set_number(currentPoints%10)
		newNumber.position.x = offset
		add_child(newNumber)
		offset -= 32
		currentPoints /= 10

	var newNumber = number.instantiate()
	newNumber.set_number(currentPoints%10)
	newNumber.position.x = offset
	add_child(newNumber)
