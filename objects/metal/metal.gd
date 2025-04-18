extends RigidBody2D

@onready var clank_sound: AudioStreamPlayer = $ClankSound


func _on_body_entered(body: Node) -> void:

	print("here")
	
	clank_sound.play()
	collision_layer = 0
	collision_mask = 0
