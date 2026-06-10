extends PointLight2D

@onready var torch: PointLight2D = $"."


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lightPulse = get_tree().create_tween()
	lightPulse.set_loops()
	lightPulse.tween_property(torch, "scale", Vector2(1.1,1.1), 1).set_trans(Tween.TRANS_BACK)
	lightPulse.tween_property(torch, "scale", Vector2(1.2,1.2), 1).set_trans(Tween.TRANS_CIRC)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
