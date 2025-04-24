extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var mainMenu: PackedScene = load("res://scenes/mainMenu/main_menu.tscn")
@onready var endGameMenuScore: PointsDisplay = $Buttons/pointsDisplay

@onready var play: Control = $Buttons/Play
@onready var scores: Control = $Buttons/Scores
@onready var sounds: Control = $Buttons/Sounds
@onready var quit: Control = $Buttons/Quit



@export var enabled: bool = false:
	set(value):
		enabled = value
		if play == null or scores == null or sounds == null or quit == null:
			return
		setChildEnabled(value)

## Called by game manager to trigger the game end animation
func gameEndAnimation(clockwise: bool) -> void:
	if clockwise:
		animation_player.play("gameEndClockWise")
	else:
		animation_player.play("gameEnd")

func setChildEnabled(value: bool):
	play.enabled = value
	scores.enabled = value
	sounds.enabled = value
	quit.enabled = value

func _on_play_pressed() -> void:
	animation_player.play("play")

func _on_scores_pressed() -> void:
	animation_player.play("gameEndToScore")

func _on_score_board_menu_close_score_board() -> void:
	animation_player.play("gameEndToScore", -1, -1, true)

func _on_sounds_pressed() -> void:
	animation_player.play("gameEndToSound")

func _on_sound_settings_close_menu() -> void:
	animation_player.play("gameEndToSound", -1, -1, true)

func _on_quit_pressed() -> void:
	animation_player.play("quit")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"play":
			get_tree().reload_current_scene()
		"quit":
			get_tree().change_scene_to_packed(mainMenu)
