extends Node


var active_catalyst: Area2D = null


func set_active_catalyst(catalyst: Area2D):
	if active_catalyst and active_catalyst != catalyst:
		active_catalyst.UnactivatedState()
	active_catalyst = catalyst

func get_respawn_position() -> Vector2:
	return active_catalyst.global_position if active_catalyst else Vector2.ZERO
