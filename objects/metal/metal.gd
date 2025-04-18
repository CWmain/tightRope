extends RigidBody2D

@onready var clank_sound: AudioStreamPlayer = $ClankSound


func _process(delta: float) -> void:
	if position.y > 200 and !clank_sound.playing:
		queue_free()

func _on_body_entered(body: Node) -> void:
	clank_sound.play()
	collision_layer = 0
	collision_mask = 0
