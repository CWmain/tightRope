extends Node2D

@export var rock: PackedScene

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SpawnRock"):
		var newRock: RigidBody2D = rock.instantiate()
		newRock.linear_velocity = Vector2(1000, -400)
		add_child(newRock)
		
