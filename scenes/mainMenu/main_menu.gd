extends Control

var play: PackedScene = preload("res://scenes/main/main.tscn")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(play)

func _on_sounds_pressed() -> void:
	print("Open sound settings")
