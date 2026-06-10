extends Node2D

var inRangeCatalyst := false

func _on_scroll_area_entered(area: Area2D) -> void:
	inRangeCatalyst = true
	print("Space to jump")




func _on_scroll_area_exited(area: Area2D) -> void:
	inRangeCatalyst = false
