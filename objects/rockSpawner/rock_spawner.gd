@tool
extends Node2D
class_name Spawner

@export var globalWarningLocation: Vector2:
	set(value):
		globalWarningLocation = value
		if warning != null:
			warning.position = to_local(globalWarningLocation)
@export var spawnSpeed: Vector2

@onready var warning: AnimatedSprite2D = $Warning
@onready var attack_timer: Timer = $attackTimer

var newProjectile: RigidBody2D

func _ready() -> void:
	warning.position = to_local(globalWarningLocation)
	if !Engine.is_editor_hint():
		warning.hide()

func _on_attack_timer_timeout() -> void:
	newProjectile.linear_velocity = spawnSpeed
	add_child(newProjectile)
	warning.hide()
	
func createProjectile(toUse: PackedScene):
	newProjectile = toUse.instantiate()
	warning.show()
	attack_timer.start()

	
