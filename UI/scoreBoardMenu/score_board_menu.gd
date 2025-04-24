extends Control

@export var saveFileString: String = "user://scores.txt"

@onready var list: VBoxContainer = $VBoxContainer/list

var pointDisplay: PackedScene = preload("res://objects/pointsDisplay/points_display.tscn")

signal closeScoreBoard

func _ready() -> void:
	loadScores()

func showScores():
	removeListChildren()
	loadScores()

func loadScores():
	var file = FileAccess.open(saveFileString, FileAccess.READ)
	var stringFile: String
	if (FileAccess.file_exists(saveFileString)):
		file = FileAccess.open(saveFileString, FileAccess.READ)
		stringFile = file.get_as_text()
		file.close()
	
	# Get the highscore list
	var highScores: Array[int]
	if (stringFile.length() > 0):
		highScores = str_to_var(stringFile)
	
	# Re-sort highscore list
	highScores.sort()

	# Generate labels and append to list
	for i in range(highScores.size()-1,-1, -1):
		print(i)
		var c: Control = Control.new()
		var item: PointsDisplay = pointDisplay.instantiate()
		item.centered = true
		item.scale = Vector2(0.1,0.1)
		item.value = highScores[i]
		item.paused = false
		c.add_child(item)
		c.custom_minimum_size = Vector2(100,50)
		item.position = c.custom_minimum_size/2
		list.add_child(c)
		

func removeListChildren():
	for child in list.get_children():
		list.remove_child(child)
		child.queue_free()


func _on_back_pressed():
	closeScoreBoard.emit()
