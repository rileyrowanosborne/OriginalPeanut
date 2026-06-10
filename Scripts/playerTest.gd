extends CharacterBody2D





@onready var ray_cast_right: RayCast2D = $RayCasts/RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCasts/RayCastLeft
@onready var ray_cast_bottom: RayCast2D = $RayCasts/RayCastBottom
@onready var death_timer: Timer = $DeathTimer




func _process(delta: float) -> void:
	if Engine.time_scale < 1 and !GameState.playerAlive:
		GameState.playerAlive = true
		death_timer.start()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.gamePaused = false
	GameState.playerAlive = true
	

#Physics and movement
func _physics_process(delta: float) -> void:
	
	#Physics Variables
	var FallMultiplier := 2
	var jumpVelocity := -300
	var FALL_MULTIPLIER := 1.3
	var WALK_SPEED = 150.0
	var AIR_WALK_SPEED = 130.0
	var AIR_ACCELERATION = 2.5
	var AIR_RESISTANCE = 100.0
	var RUN_SPEED = 225.0
	var acceleration = .5
	var deceleration = .9
	
	
	var isTouchingWall = (ray_cast_right.is_colliding() || ray_cast_left.is_colliding())
	
	#Gravity application
	if !is_on_floor() && GameState.playerAlive:
		if velocity.y > 0 && !isTouchingWall:
			velocity+= get_gravity() * FallMultiplier * delta
		else:
			velocity+= get_gravity() * delta
	
	#Gets the input code for direction: 1, 0, -1.
	var direction  = 0
	if GameState.playerAlive and !GameState.gamePaused:
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = 0
		
	
	if direction != 0:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, direction * WALK_SPEED, WALK_SPEED * acceleration)
		else:
			velocity.x = move_toward(velocity.x, direction * AIR_WALK_SPEED, AIR_ACCELERATION * WALK_SPEED)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, WALK_SPEED * deceleration)
		else:
			velocity.x = move_toward(velocity.x, 0, AIR_RESISTANCE * delta)
	
	
	#Jump mechanic
	if Input.is_action_just_pressed("jump") && is_on_floor() && GameState.playerAlive:
		velocity.y = jumpVelocity
	
	#Adds variable jump
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.4

	#Wall slide mechanic
	if isTouchingWall && GameState.playerAlive:
		velocity.y *= .7
	
	#Fall through a platform check
	if is_on_floor() and Input.is_action_just_pressed("Drop") and ray_cast_bottom.is_colliding() && GameState.playerAlive:
		position.y += 1
	
	move_and_slide()

#Body entered checks
func _on_baltrude_body_entered(_body: Node2D) -> void:
	GameState.inRangeBaltrude = true

func _on_baltrude_body_exited(_body: Node2D) -> void:
	GameState.inRangeBaltrude = false


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	Hud.you_died.visible = false
	get_tree().reload_current_scene()
