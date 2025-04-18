extends RigidBody2D

@onready var hit_sound: AudioStreamPlayer = $HitSound
var hitCount: int = 0

func _process(delta: float) -> void:
	if position.y > 800 and !hit_sound.playing:
		queue_free()

func _on_body_entered(body: Node) -> void:
	if hitCount == 0:
		var pitchOffest: float = (randf())
		hit_sound.pitch_scale = 1+pitchOffest
		hit_sound.play()
	elif hitCount >= 2:
		collision_layer = 0
		collision_mask = 0
		
	hitCount += 1
