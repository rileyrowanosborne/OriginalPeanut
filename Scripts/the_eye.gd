extends Node2D


@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shot_timer: Timer = $ShotTimer
@onready var the_eye: Node2D = $"."
@onready var shootPoint: Marker2D = $Marker2D



@export var projectile_scene: PackedScene

const MovementSpeed := 20

var projectileSpeed := 50
var projectileInterval := 3.0
var alive := true
var eyeDirection = 1

func _ready() -> void:
	alive = true
	animated_sprite.flip_h = true
	shot_timer.wait_time = projectileInterval
	shot_timer.start()


func _process(delta: float) -> void:
	if alive:
		position.x -= eyeDirection * MovementSpeed * delta
	
	flipAndMove()


func flipAndMove():
	if ray_cast_left.is_colliding():
		eyeDirection = -1
		animated_sprite.flip_h = false
	if ray_cast_right.is_colliding():
		eyeDirection = 1
		animated_sprite.flip_h = true


func shootprojectile():
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(projectile)
		projectile.global_position = shootPoint.global_position
		
		if eyeDirection == -1:
		
			projectile.set_velocity(Vector2.RIGHT * projectileSpeed)
		
		else:
			projectile.set_velocity(Vector2.LEFT * projectileSpeed)



func _on_shot_timer_timeout() -> void:
	shootprojectile()
