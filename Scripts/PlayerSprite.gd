extends AnimatedSprite2D


@onready var animated_sprite: AnimatedSprite2D = $"."


@onready var player: CharacterBody2D = $".."
@onready var ray_cast_right: RayCast2D = $"../RayCasts/RayCastRight"
@onready var ray_cast_left: RayCast2D = $"../RayCasts/RayCastLeft"





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var direction := Input.get_axis("move_left","move_right")
	
	if direction == 0 and GameState.playerAlive:
		setAnimation("Idle")
	elif direction != 0 and GameState.playerAlive:
		setAnimation("Walking")

	
	if GameState.playerAlive:
		if direction == 1:
			setFlip(1)
		elif direction == -1:
			setFlip(-1)
	
	if ray_cast_left.is_colliding() && !player.is_on_floor() && GameState.playerAlive:
		setAnimation("Sliding_left")
	elif ray_cast_right.is_colliding() && !player.is_on_floor() && GameState.playerAlive:
		setAnimation("Sliding_right")
	
	if !player.is_on_floor() && GameState.playerAlive && (!ray_cast_left.is_colliding() || ray_cast_right.is_colliding()):
		setAnimation("Falling")
	
	if GameState.gamePaused && GameState.playerAlive:
		setAnimation("Pause Screen")
	

func setFlip(direction : int):
	var shouldFlip := direction == -1
	if animated_sprite.flip_h != shouldFlip:
		animated_sprite.flip_h = shouldFlip

func setAnimation(animName : String):
	if animated_sprite.animation != animName:
		animated_sprite.play(animName)
