extends Control

signal closeMenu

func _on_back_pressed() -> void:
	closeMenu.emit()
