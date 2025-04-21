extends Control


@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var sound_settings: Control = $SoundSettings

var play: PackedScene = preload("res://scenes/main/main.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(play)

func _on_sounds_pressed() -> void:
	v_box_container.hide()
	sound_settings.show()

func _on_sound_settings_close_menu() -> void:
	v_box_container.show()
	sound_settings.hide()
