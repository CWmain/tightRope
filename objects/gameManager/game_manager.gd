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

func _on_spawn_stuff_timeout() -> void:
	if randf() > 0.7:
		topLeft.createProjectile(projectiles[round(randf()*2)])
	if randf() > 0.7:
		topRight.createProjectile(projectiles[round(randf()*2)])
	if randf() > 0.7:
		bottomRight.createProjectile(projectiles[round(randf()*2)])
	if randf() > 0.7:
		bottomLeft.createProjectile(projectiles[round(randf()*2)])
