@tool
extends Control
class_name AnimatedLabel

@export var spriteFrames: SpriteFrames:
	set(value):
		spriteFrames = value
		if animated_label_texture != null:
			updateButton()
@export var textureScale: float = 1:
	set(value):
		textureScale = value
		if animated_label_texture != null:
			updateButton()

@onready var animated_label_texture: AnimatedSprite2D = $AnimatedLabelTexture

func _ready() -> void:
	assert(spriteFrames != null)
	updateButton()

func pauseAnimation() -> void:
	animated_label_texture.speed_scale = 0
	
func playAnimation() -> void:
	animated_label_texture.speed_scale = 1

func updateButton() -> void:
	animated_label_texture.scale = Vector2(textureScale, textureScale)
	animated_label_texture.sprite_frames = spriteFrames
	custom_minimum_size = animated_label_texture.sprite_frames.get_frame_texture("default", 0).get_size()*animated_label_texture.scale
	animated_label_texture.speed_scale = 0
	animated_label_texture.play("default")
	animated_label_texture.position = custom_minimum_size/2
	
