extends Node

# This will manage the timings of object spawns


@export_category("Projectiles")
@export var metal: PackedScene
@export var tape: PackedScene
@export var scissors: PackedScene

@export_category("Spawner Locations")
@export var topLeft: Spawner
@export var topRight: Spawner
@export var bottomLeft: Spawner
@export var bottomRight: Spawner



func _on_spawn_stuff_timeout() -> void:
	topLeft.createProjectile(scissors)
	#topRight.createProjectile(metal)
	#bottomRight.createProjectile(metal)
	bottomLeft.createProjectile(scissors)
