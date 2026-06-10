extends Node2D


func _ready() -> void:
	hideAndShowUI()



func hideAndShowUI():
	Hud.hud.visible = true
	Hud.dialogue_hud.visible = true
