extends Node2D

@export var torqueForce: float = 10000

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

var bonusForce: float = 0

signal fallen

func _physics_process(delta: float) -> void:
	if rigid_body_2d.rotation > PI/2 || rigid_body_2d.rotation < -PI/2:
		fallen.emit()
		printerr("LOST")
	
	
	rigid_body_2d.apply_torque(2000)
	if Input.is_action_pressed("Left"):
		rigid_body_2d.apply_torque_impulse(-(torqueForce+bonusForce))
		bonusForce += 100
	
	if Input.is_action_pressed("Right"):
		rigid_body_2d.apply_torque_impulse(torqueForce+bonusForce)
		bonusForce += 100

	if Input.is_action_just_released("Left") or Input.is_action_just_released("Right"):
		bonusForce = 0
