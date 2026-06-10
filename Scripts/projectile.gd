extends Node2D

const ProjectileSpeed := 50
var direction := 1
var velocity := Vector2.ZERO


@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight



func _process(_delta: float) -> void:
	if ray_cast_right.is_colliding():
		queue_free()



func _physics_process(delta: float) -> void:
	position += velocity * delta


func set_velocity(vel: Vector2):
	velocity = vel
	
	if sprite_2d:
		sprite_2d.flip_h = velocity.x > 0
	



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
