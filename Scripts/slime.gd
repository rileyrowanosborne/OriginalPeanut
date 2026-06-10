extends Node2D

var alive : bool = true
var direction = 1


const speed = 50


@onready var collision_shape_2d: CollisionShape2D = $Killzone/CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft


func _ready() -> void:
	alive = true
	


func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_right.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	if alive:
		position.x -= direction * speed * delta
	

	
	
	if (!alive):
		death()
	else:
		animated_sprite.play("Walking")
		
	

func death():
	animated_sprite.play("Death")
	






func _on_right_area_area_entered(_area: Area2D) -> void:
	
	death()


func _on_left_area_area_entered(_area: Area2D) -> void:
	death()
