extends Node2D

@export var rock: PackedScene
@export var globalWarningLocation: Vector2
@export var spawnSpeed: Vector2

@onready var warning: AnimatedSprite2D = $Warning

func _ready() -> void:
	assert(rock != null)
	warning.position = to_local(globalWarningLocation)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SpawnRock"):
		var newRock: RigidBody2D = rock.instantiate()
		newRock.linear_velocity = spawnSpeed
		add_child(newRock)
		
