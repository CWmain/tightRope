@tool
extends Node2D

@export var rock: PackedScene
@export var globalWarningLocation: Vector2:
	set(value):
		globalWarningLocation = value
		if warning != null:
			warning.position = to_local(globalWarningLocation)
@export var spawnSpeed: Vector2

@onready var warning: AnimatedSprite2D = $Warning
@onready var attack_timer: Timer = $attackTimer

func _ready() -> void:
	assert(rock != null)
	if !Engine.is_editor_hint():
		warning.position = to_local(globalWarningLocation)
		warning.hide()

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if Input.is_action_just_pressed("SpawnRock"):
		warning.show()
		attack_timer.start()
		

func _on_attack_timer_timeout() -> void:
	var newRock: RigidBody2D = rock.instantiate()
	newRock.linear_velocity = spawnSpeed
	add_child(newRock)
	warning.hide()
