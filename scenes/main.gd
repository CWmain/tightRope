extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var walker: Node2D = $Walker

func _ready() -> void:
	animation_player.play("intro")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	print("Do the stuff to start the game")
