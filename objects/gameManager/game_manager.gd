extends Node
class_name GameManager
# This will manage the timings of object spawns, points of the player


@export_category("Projectiles")
@export var projectiles: Array[PackedScene]

#TODO: Remove if un-needed
@export var metal: PackedScene
@export var tape: PackedScene
@export var scissors: PackedScene

@export_category("Spawner Locations")
@export var topLeft: Spawner
@export var topRight: Spawner
@export var bottomLeft: Spawner
@export var bottomRight: Spawner

@export_category("Points")
@export var pointsPerSecond: int = 10

@export_category("Display")
@export var pointsDisplay: PointsDisplay
@export var endGameMenu: Control
@export var animationPlayer: AnimationPlayer

@export_category("Other")
@export var walker: Walker
@export var saveFileString: String = "user://scores.txt"


@onready var earn_points: Timer = $EarnPoints
@onready var increment_chance_to_fire: Timer = $IncrementChanceToFire
@onready var spawn_stuff: Timer = $SpawnStuff


var chanceToFire: float = 0.1
var points: int = 0
var gameRunning: bool = true

signal newScore

func _ready() -> void:
	walker.fallen.connect(endGame)

func _on_spawn_stuff_timeout() -> void:
	var roll: float = randf()
	if points < 200:
		spawnOne(roll)
	elif points < 400:
		spawnTwo(roll)
	elif points < 600:
		spawnThree(roll)
	else:
		if roll < 0.1:
			spawnOne(roll)
		elif roll < 0.2:
			spawnTwo(roll)
		elif roll < 0.6:
			spawnThree(roll)
		else:
			spawnFour()

func spawnOne(roll: float)->void:
	if roll <= 0.25:
		topLeft.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.5:
		topRight.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.75:
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	else:
		bottomLeft.createProjectile(projectiles[round(randf()*2)])

func spawnTwo(roll: float) -> void:
	if roll <= 0.16:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		topRight.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.32:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.48:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.64:
		topRight.createProjectile(projectiles[round(randf()*2)])
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
	elif roll <= 0.8:
		topRight.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	else:
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])

func spawnThree(roll: float) -> void:
	if roll < 0.25:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		topRight.createProjectile(projectiles[round(randf()*2)])
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
	elif roll < 0.5:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		topRight.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	elif roll < 0.75:
		topLeft.createProjectile(projectiles[round(randf()*2)])
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	else:
		topRight.createProjectile(projectiles[round(randf()*2)])
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
		bottomRight.createProjectile(projectiles[round(randf()*2)])

func spawnFour() -> void:
	topLeft.createProjectile(projectiles[round(randf()*2)])
	topRight.createProjectile(projectiles[round(randf()*2)])
	bottomLeft.createProjectile(projectiles[round(randf()*2)])
	bottomRight.createProjectile(projectiles[round(randf()*2)])

func _on_increment_chance_to_fire_timeout() -> void:
	chanceToFire = chanceToFire+0.1 if chanceToFire <= 0.9 else 1

func _on_earn_points_timeout() -> void:
	points += pointsPerSecond
	pointsDisplay.value = points
	newScore.emit()

func _on_game_start_delay_timeout() -> void:
	earn_points.start()

func saveScore():
	var file = FileAccess.open(saveFileString, FileAccess.READ)
	var stringFile: String
	if (FileAccess.file_exists(saveFileString)):
		file = FileAccess.open(saveFileString, FileAccess.READ)
		stringFile = file.get_as_text()
		file.close()
	
	# Get the highscore list
	var highScores: Array[int]
	if (stringFile.length() == 0):
		highScores = [points]
	else:
		highScores = str_to_var(stringFile)
		highScores.append(points)
	
	# Re-sort highscore list
	highScores.sort()
	
	# Ensure only 5 Highscores are stored
	if (highScores.size() > 10):
		highScores.pop_front()
	
	# Save highscore list to file
	file = FileAccess.open(saveFileString, FileAccess.WRITE)
	file.store_line(var_to_str(highScores))
	file.close()

func endGame() -> void:
	if !gameRunning:
		return
	earn_points.stop()
	spawn_stuff.stop()
	increment_chance_to_fire.stop()
	animationPlayer.play("endGame")
	endGameMenu.gameEndAnimation(walker.rigid_body_2d.rotation > 0)
	endGameMenu.endGameMenuScore.value = points
	saveScore()
	gameRunning = false
