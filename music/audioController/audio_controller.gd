extends Node

@onready var game_music: AudioStreamPlayer = $GameMusic
@onready var menu_music: AudioStreamPlayer = $MenuMusic

func playMenu() -> void:
	print("Menu")
	game_music.stream_paused = true
	if !menu_music.playing:
		menu_music.play()
	menu_music.stream_paused = false
	
func playGame() -> void:
	print("Game")
	menu_music.stream_paused = true
	if !game_music.playing:
		game_music.play()
	game_music.stream_paused = false

func pauseMusic() -> void:
	print("Pause")
	game_music.stream_paused = true
	menu_music.stream_paused = true
