extends Node2D

@export var torqueForce: float = 15000
@export var bonusForceIncrease: float = 500
@export var isActive: bool = false

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

@onready var right_sweat: CPUParticles2D = $RigidBody2D/RightSweat
@onready var left_sweat: CPUParticles2D = $RigidBody2D/LeftSweat

var bonusForce: float = 0
var lastDirection: int = 0

signal fallen



func _physics_process(delta: float) -> void:
	if !isActive:
		rigid_body_2d.angular_velocity = 0
		return
	
	if rigid_body_2d.rotation > PI/4 || rigid_body_2d.rotation < -PI/4:
		right_sweat.emitting = true
		left_sweat.emitting = true
	else:
		right_sweat.emitting = false
		left_sweat.emitting = false
	
	if rigid_body_2d.rotation > PI/2 || rigid_body_2d.rotation < -PI/2:
		fallen.emit()
		printerr("LOST")
	
	
	#rigid_body_2d.apply_torque(2000)
	if Input.is_action_pressed("Left"):
		if lastDirection == 1:
			bonusForce = 0
		rigid_body_2d.apply_torque_impulse(-(torqueForce+bonusForce))
		bonusForce += bonusForceIncrease
		lastDirection = -1
	
	if Input.is_action_pressed("Right"):
		if lastDirection == -1:
			bonusForce = 0
		rigid_body_2d.apply_torque_impulse(torqueForce+bonusForce)
		bonusForce += bonusForceIncrease
		lastDirection = 1

	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Right"):
		bonusForce = move_toward(bonusForce, 0, bonusForceIncrease)
