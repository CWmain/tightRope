extends Node2D

@export var rock: PackedScene

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("SpawnRock"):
		add_child(rock.instantiate())
