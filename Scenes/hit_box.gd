class_name Hitbox

extends Area2D




func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hurtbox"):
		pass
