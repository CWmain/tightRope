extends Control

signal closeMenu

@onready var master: Control = %Master
@onready var all_label: Control = $VBoxContainer/HBoxContainer/AllLabel

@onready var sfx: Control = %SFX
@onready var sfx_label: Control = $VBoxContainer/HBoxContainer2/SFXLabel

@onready var music: Control = %Music
@onready var music_label: Control = $VBoxContainer/HBoxContainer3/MusicLabel

func _ready() -> void:
	master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	music.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_master_value_updated() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(master.value))

func _on_sfx_value_updated() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(sfx.value))

func _on_music_value_updated() -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(music.value))

func _on_animated_back_pressed() -> void:
	closeMenu.emit()

func _on_master_mouse_entered() -> void:
	all_label.playAnimation()

func _on_master_mouse_exited() -> void:
	all_label.pauseAnimation()

func _on_sfx_mouse_entered() -> void:
	sfx_label.playAnimation()

func _on_sfx_mouse_exited() -> void:
	sfx_label.pauseAnimation()

func _on_music_mouse_entered() -> void:
	music_label.playAnimation()

func _on_music_mouse_exited() -> void:
	music_label.pauseAnimation()
