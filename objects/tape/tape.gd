extends RigidBody2D

@onready var hit_sound: AudioStreamPlayer = $HitSound

func _process(delta: float) -> void:
	if position.y > 200 and !hit_sound.playing:
		queue_free()

func _on_body_entered(body: Node) -> void:
	var pitchOffest: float = (randf()*0.4)-0.2
	hit_sound.pitch_scale = 1+pitchOffest
	hit_sound.play()
	collision_layer = 0
	collision_mask = 0
