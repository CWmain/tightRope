extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var mainMenu: PackedScene = load("res://scenes/mainMenu/main_menu.tscn")
@onready var endGameMenuScore: PointsDisplay = $Buttons/pointsDisplay



## Called by game manager to trigger the game end animation
func gameEndAnimation() -> void:
	animation_player.play("gameEnd")

func _on_play_pressed() -> void:
	animation_player.play("play")

func _on_scores_pressed() -> void:
	print("So score menu")

func _on_sounds_pressed() -> void:
	animation_player.play("gameEndToSound")

func _on_sound_settings_close_menu() -> void:
	animation_player.play("gameEndToSound", -1, -1, true)

func _on_quit_pressed() -> void:
	get_tree().change_scene_to_packed(mainMenu)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"play":
			get_tree().reload_current_scene()
