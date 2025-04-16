extends Node2D

@export var rock: PackedScene
@export var spawnSpeed: Vector2

func _ready() -> void:
	assert(rock != null)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SpawnRock"):
		var newRock: RigidBody2D = rock.instantiate()
		newRock.linear_velocity = spawnSpeed
		add_child(newRock)
		
