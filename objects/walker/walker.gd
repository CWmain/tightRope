extends Node2D
class_name Walker

@export var torqueForce: float = 15000
@export var bonusForceIncrease: float = 500
@export var isActive: bool = false

@onready var rigid_body_2d: RigidBody2D = $RigidBody2D

@onready var right_sweat: CPUParticles2D = $RigidBody2D/RightSweat
@onready var left_sweat: CPUParticles2D = $RigidBody2D/LeftSweat

@onready var walker_texture: AnimatedSprite2D = $RigidBody2D/WalkerTexture

var bonusForce: float = 0
var lastDirection: int = 0
var falledEmmited: bool = false
signal fallen

func _physics_process(delta: float) -> void:
	if !isActive:
		walker_texture.speed_scale = 0
		rigid_body_2d.angular_velocity = 0
		rigid_body_2d.rotation = 0
		return
		
	walker_texture.speed_scale = 1
	
	if rigid_body_2d.rotation > PI/4 || rigid_body_2d.rotation < -PI/4:
		right_sweat.emitting = true
		left_sweat.emitting = true
	else:
		right_sweat.emitting = false
		left_sweat.emitting = false

	if !falledEmmited and (rigid_body_2d.rotation > 2*PI/3 || rigid_body_2d.rotation < -2*PI/3):
		fallen.emit()
		falledEmmited = true
	
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
