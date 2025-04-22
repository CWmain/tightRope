@tool
extends Control

@export var value: float:
	set(a):
		value = clamp(snapped(a, step), minValue, maxValue)
		updateBar()

@export var minValue: float = 0:
	set(a):
			minValue = a
			updateBar()
@export var maxValue: float = 100:
	set(a):
		maxValue = a if a != 0 else 1.0
		updateBar()

@export var step: float = 0.01

@onready var full_bar: AnimatedSprite2D = $FullBar
@onready var empty_bar: Sprite2D = $EmptyBar

@onready var monotone: AudioStreamPlayer = $Monotone

var trackMouse: bool = false

signal valueUpdated

func _ready() -> void:
	assert(minValue <= maxValue, "Max is smaller than min")
	custom_minimum_size.x = max(empty_bar.texture.get_width()*empty_bar.scale.x, full_bar.sprite_frames.get_frame_texture("default", 0).get_width()*full_bar.scale.x)
	custom_minimum_size.y = max(empty_bar.texture.get_height()*empty_bar.scale.y, full_bar.sprite_frames.get_frame_texture("default", 0).get_height()*full_bar.scale.y)-25
	full_bar.material = full_bar.material.duplicate()
	empty_bar.position = custom_minimum_size/2.0
	full_bar.position = custom_minimum_size/2.0
	full_bar.speed_scale = 0
	updateBar()

func _process(_delta: float) -> void:
	if trackMouse:
		if !monotone.playing:
			monotone.play()
		monotone.stream_paused = false
		var width: float = custom_minimum_size.x
		var localMouse: float = get_local_mouse_position().x
		var valuePercent = (localMouse)/width
		
		monotone.pitch_scale = clamp(0.5+(valuePercent/2), 0.5, 1.0)
		
		# Calculate the new value based on the dragging
		value = valuePercent*(maxValue-minValue) + minValue
		#print("Tracking ", name, " with value ", value)

func updateBar() -> void:
	if full_bar == null:
		return
	full_bar.material.set_shader_parameter("percent", (value-minValue)/(maxValue-minValue))

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("MousePress"):
		trackMouse = true
		
	elif event.is_action_released("MousePress"):
		trackMouse = false
		monotone.stream_paused = true
		valueUpdated.emit()

func _on_mouse_entered() -> void:
	full_bar.speed_scale = 1

func _on_mouse_exited() -> void:
	full_bar.speed_scale = 0
