extends Node

# This will manage the timings of object spawns


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

var chanceToFire: float = 0.1

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
