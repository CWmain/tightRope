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

@export_category("Other")
@export var walker: Walker


@onready var earn_points: Timer = $EarnPoints
@onready var increment_chance_to_fire: Timer = $IncrementChanceToFire
@onready var spawn_stuff: Timer = $SpawnStuff


var chanceToFire: float = 0.1
var points: int = 0

signal newScore

func _ready() -> void:
	walker.fallen.connect(endGame)

func _on_spawn_stuff_timeout() -> void:
	if randf() <= chanceToFire:
		topLeft.createProjectile(projectiles[round(randf()*2)])
	if randf() <= chanceToFire:
		topRight.createProjectile(projectiles[round(randf()*2)])
	if randf() <= chanceToFire:
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	if randf() <= chanceToFire:
		bottomLeft.createProjectile(projectiles[round(randf()*2)])

func _on_increment_chance_to_fire_timeout() -> void:
	chanceToFire = chanceToFire+0.1 if chanceToFire <= 0.9 else 1

func _on_earn_points_timeout() -> void:
	points += pointsPerSecond
	pointsDisplay.value = points
	newScore.emit()

func _on_game_start_delay_timeout() -> void:
	earn_points.start()

func endGame() -> void:
	earn_points.stop()
	spawn_stuff.stop()
	increment_chance_to_fire.stop()
	#walker.process_mode = Node.PROCESS_MODE_DISABLED
	print("Game is ended do more stuff")
