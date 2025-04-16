extends RigidBody2D

func _process(delta: float) -> void:
	if position.y > 200:
		queue_free()
