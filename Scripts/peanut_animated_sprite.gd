extends AnimatedSprite2D

@onready var animated_sprite: AnimatedSprite2D = $"."
@onready var player: CharacterBody2D = %Player
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var sword: Node2D = $"../Sword3"
@onready var sword_sprite_right: Sprite2D = $"../Sword3/RightArea/SwordSpriteRight"
@onready var sword_sprite_left: Sprite2D = $"../Sword3/LeftArea/SwordSpriteLeft"


var lastDirection = 0
var playerPaused = false
var playerAlive = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerAlive = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pauseCheck()
	AnimationManager()


func AnimationManager():
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction == 1:
		lastDirection = 1
	elif direction == -1:
		lastDirection = -1
	
	#Plays idle and walking animations.
	if !playerPaused && playerAlive && player.is_on_floor():
		if direction == 0:
			animated_sprite.play("1_Idle")
		elif !direction == 0:
			animated_sprite.play("Walking")
		
		if direction == -1:
			animated_sprite.flip_h = true
		elif direction == 1:
			animated_sprite.flip_h = false
	
	elif !playerPaused && playerAlive && !player.is_on_floor():
		if ray_cast_left.is_colliding() || ray_cast_right.is_colliding():
			if (direction == 0 && lastDirection == -1) || direction == -1:
				animated_sprite.play("Sliding_left")
				animated_sprite.flip_h = true
			elif (direction == 0 && lastDirection == 1) || direction == 1:
				animated_sprite.play("Sliding_left")
				animated_sprite.flip_h = false
		else:
			animated_sprite.play("Falling")

	
	#plays the death animation.
	elif !playerPaused && !playerAlive:
		animated_sprite.play("Death")
	
	
	#Sword animations and such.
	if sword.visible == true:
		if direction > 0:
			sword_sprite_right.visible = true
			sword_sprite_left.visible = false
		elif direction < 0:
			sword_sprite_right.visible = false
			sword_sprite_left.visible = true
		elif direction == 0 and lastDirection > 0:
			sword_sprite_right.visible = true
			sword_sprite_left.visible = false
		elif direction == 0 and lastDirection < 0:
			sword_sprite_right.visible = false
			sword_sprite_left.visible = true

func pauseCheck():
	if get_tree().paused == true:
		playerPaused = true
	else:
		playerPaused = false

func aliveCheck():
	if Engine.time_scale < 1 and playerAlive:
		playerAlive = false
