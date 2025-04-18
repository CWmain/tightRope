extends RigidBody2D

@onready var clank_sound: AudioStreamPlayer = $ClankSound


func _process(delta: float) -> void:
	if position.y > 800 and !clank_sound.playing:
		queue_free()

func _on_body_entered(body: Node) -> void:
	var pitchOffest: float = (randf()*0.5)-0.25
	clank_sound.pitch_scale = 1+pitchOffest
	clank_sound.play()
	collision_layer = 0
	collision_mask = 0
