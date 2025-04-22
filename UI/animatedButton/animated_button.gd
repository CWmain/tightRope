@tool
extends Control

@export var spriteFrames: SpriteFrames:
	set(value):
		spriteFrames = value
		if animated_button_texture != null:
			updateButton()
@export var textureScale: float = 1:
	set(value):
		textureScale = value
		if animated_button_texture != null:
			updateButton()

@onready var animated_button_texture: AnimatedSprite2D = $AnimatedButtonTexture

signal pressed

func _ready() -> void:
	assert(spriteFrames != null)
	updateButton()

func _on_mouse_entered() -> void:
	animated_button_texture.speed_scale = 1

func _on_mouse_exited() -> void:
	animated_button_texture.speed_scale = 0

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("MousePress"):
		pressed.emit()

func updateButton() -> void:
	animated_button_texture.scale = Vector2(textureScale, textureScale)
	animated_button_texture.sprite_frames = spriteFrames
	custom_minimum_size = animated_button_texture.sprite_frames.get_frame_texture("default", 0).get_size()*animated_button_texture.scale
	animated_button_texture.speed_scale = 0
	animated_button_texture.play("default")
	animated_button_texture.position = custom_minimum_size/2
	
