extends Control

@onready var main_menu_buttons: VBoxContainer = $MainMenuButtons
@onready var sound_settings: Control = $SoundSettings
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var sweat: CPUParticles2D = $sweat

var play: PackedScene = preload("res://scenes/main/main.tscn")

func _ready() -> void:
	sweat.emitting = true
	animation_player.play("Intro")

func _on_play_pressed() -> void:
	animation_player.play("MenuToPlay")

func _on_sounds_pressed() -> void:
	animation_player.play("MenuToSound")

func _on_sound_settings_close_menu() -> void:
	animation_player.play("MenuToSound", -1, -1, true)

func _on_scores_pressed() -> void:
	animation_player.play("MenuToScore")

func _on_score_board_menu_close_score_board() -> void:
	animation_player.play("MenuToScore", -1, -1, true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"MenuToPlay":
			get_tree().change_scene_to_packed(play)
