extends Control

signal closeMenu

@onready var master: Control = %Master
@onready var sfx: Control = %SFX
@onready var music: Control = %Music

func _ready() -> void:
	master.value = db_to_linear(AudioServer.get_bus_volume_db(0))
	sfx.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	music.value = db_to_linear(AudioServer.get_bus_volume_db(2))

func _on_back_pressed() -> void:
	closeMenu.emit()

func _on_master_value_updated() -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(master.value))

func _on_sfx_value_updated() -> void:
	AudioServer.set_bus_volume_db(1, linear_to_db(sfx.value))

func _on_music_value_updated() -> void:
	AudioServer.set_bus_volume_db(2, linear_to_db(music.value))
