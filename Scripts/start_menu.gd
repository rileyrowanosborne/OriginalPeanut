extends Control

@onready var load_game_button: Button = $VBoxContainer/LoadGameButton


func _ready() -> void:
	if FileAccess.file_exists("user://savegame.save"):
		load_game_button.disabled = false
	else:
		load_game_button.disabled = true



func _on_load_game_button_button_down() -> void:
	SaveManager.LoadGame()
	GameState.LoadGameFlag = false
	GameState.LoadMyGame = true
	get_tree().change_scene_to_file("res://Scenes/mainLevel.tscn")


func _on_quit_button_button_down() -> void:
	SaveManager.SaveGame()
	get_tree().quit()


func _on_new_game_button_button_down() -> void:
	GameState.reset()
	get_tree().change_scene_to_file("res://Scenes/mainLevel.tscn")
