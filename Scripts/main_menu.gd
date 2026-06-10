extends Node


@onready var wait_to_start_timer: Timer = $waitToStartTimer
@onready var press_anykey_to_start: Label = $"Press anykey to start"



func _ready() -> void:

	press_anykey_to_start.visible = false
	wait_to_start_timer.start()


func _input(_event: InputEvent) -> void:
	if press_anykey_to_start.visible && Input.is_action_pressed("Start Game"):
		get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")




func _on_wait_to_start_timer_timeout() -> void:
	press_anykey_to_start.visible = true
