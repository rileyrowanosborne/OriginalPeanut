extends Area2D

@onready var timer: Timer = $Timer





func _on_body_entered(_body: CharacterBody2D) -> void:
	Engine.time_scale = 0.5
	
	
