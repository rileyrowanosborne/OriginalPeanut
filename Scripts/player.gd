extends CharacterBody2D


#Movement Variables
#physics Variables
var WALK_SPEED = 150.0
var AIR_WALK_SPEED = 130.0
var AIR_ACCELERATION = 2.5
var AIR_RESISTANCE = 100.0
var RUN_SPEED = 225.0
var acceleration = .5
var deceleration = .9
var leftWallJumpUsed = false
var rightWallJumpUsed = false
var playerAlive = true
var health = 100
var KillzoneEntered = false
var inAir = false
var wallJumpState = false
var playerPaused = false
var Gravity = 1000
var FALL_MULTIPLIER = 1.3
const exposedJumpVelocity = -350
var jumpVelocity = -300.0
const Slide_Velocity = .5
var doubleJump = false
#endregion

#Story Variables
var iceCatalystCollected = false
var fireCatalystCollected = false
var earthCatalystCollected = false
var story = 0
var TomeOneCollected = false
var TomeTwoCollected = false
var TomeThreeCollected = false
var TomeFourCollected = false
var TomeFiveCollected = false
var TomeSixCollected = false
var TomeSevenCollected = false

var savePath = "user://variable.save"

#Respawn spot.
var inRangeIce = false
var inRangeFire = false
var inResRangeKnut = false
var inResRangeMarble = false
var inResRangeDarkBrick = false
var inResRangeEndGame = false

var respawnLocation = 0
var StartGame = true

var ResIce = false
var ResFire = false
var ResBalt = false
var ResKnut = false
var ResMarble = false
var ResDarkBrick = false
var ResEndGame = false
var swordInRange = false

#Baltrude Dialogue
var inRangeBalt = false

#Knut Dialogue
var sideStory = 0
var inRangeKnut = false
var helpingKnut = false

#Tutorial Variables
var inRangeCatalystOne = false
var inRangeCatalystTwo = false

#Animation Variables
var lastDirection := 0

#Player attack
var projectileSpeed := 100


@export var projectile_scene: PackedScene

#Node Variables
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D3

@onready var coyote_timer: Timer = $"Timers/Coyote Timer"
@onready var ray_cast_right: RayCast2D = $RayCasts/RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCasts/RayCastLeft
@onready var killzones: Node2D = $"../Killzones"
@onready var jump_buffer: Timer = $"Timers/Jump Buffer"

@onready var death_timer: Timer = $"../Killzones/Death Timer"
@onready var ray_cast_bottom: RayCast2D = $RayCasts/RayCastBottom
@onready var ice_catalyst: Area2D = $"../Baltrude/Catalysts/IceCatalyst"
@onready var ice_catalyst_check_node_2: Node2D = $IceCatalystCheckNode2
@onready var wall_slide_timer: Timer = $WallSlideTimer
@onready var player: CharacterBody2D = %Player
@onready var shootPoint: Marker2D = $ShootPoint

#Attack Mechanics
@onready var sword_artifact: Area2D = $"../WorldStuff/SwordArtifact"
@onready var sword_timer: Timer = $"../HUD/DialogueHUD2/Panel/eToTake/SwordTimer"
@onready var sword: Node2D = $Sword3
@onready var right_area: Area2D = $Sword3/RightArea
@onready var sword_sprite_right: Sprite2D = $Sword3/RightArea/SwordSpriteRight
@onready var right_swing: AnimationPlayer = $Sword3/RightArea/SwordSpriteRight/RightSwing
@onready var sword_collision_right: CollisionPolygon2D = $Sword3/RightArea/SwordCollisionRight
@onready var left_area: Area2D = $Sword3/LeftArea
@onready var sword_sprite_left: Sprite2D = $Sword3/LeftArea/SwordSpriteLeft
@onready var left_swing: AnimationPlayer = $Sword3/LeftArea/SwordSpriteLeft/LeftSwing
@onready var sword_collision_left: CollisionPolygon2D = $Sword3/LeftArea/SwordCollisionLeft

#dialogue and HUD Nodes
@onready var dialogue_hud_2: Control = $"../HUD/DialogueHUD2"
@onready var panel: Panel = $"../HUD/DialogueHUD2/Panel"
@onready var q_to_talk: Label = $"../HUD/DialogueHUD2/Panel/qToTalk"
@onready var you_died: Label = $"../HUD/DialogueHUD2/YouDied"
@onready var baltrude_dialogue: Label = $"../HUD/DialogueHUD2/Panel/BaltrudeDialogue"
@onready var hud: CanvasLayer = $"../HUD"
@onready var dialogue_timer_intro: Timer = $DialogueTimerIntro
@onready var return_timer: Timer = $"../HUD/Return!"
@onready var down_there_timer: Timer = $"../HUD/Down there timer"
@onready var e_to_activate: Label = $"../HUD/DialogueHUD2/Panel/eToActivate"
@onready var tutorial_text: Label = $"../HUD/DialogueHUD2/Panel/TutorialText"
@onready var e_to_take: Label = $"../HUD/DialogueHUD2/Panel/eToTake"

#World Nodes
@onready var camera_2d: Camera2D = $Camera2D
@onready var fire_catalyst: Area2D = $"../Baltrude/Catalysts/FireCatalyst"
@onready var return_2: Timer = $"../HUD/Return_2"
@onready var elevator_one: AnimationPlayer = $"../WorldStuff/GlobalPlatforms/Platform12/ElevatorOne"
@onready var platform_12: AnimatableBody2D = $"../WorldStuff/GlobalPlatforms/Platform12"
@onready var elevator_two: AnimationPlayer = $"../WorldStuff/GlobalPlatforms/Platform13/ElevatorTwo"
@onready var wall_coyote_timer_2: Timer = $WallCoyoteTimer2

#Magic Wall Nodes
@onready var magic_wall_1: StaticBody2D = $"../WorldStuff/MagicWalls/IceWalls/MagicWall1"
@onready var magic_wall_2: StaticBody2D = $"../WorldStuff/MagicWalls/IceWalls/MagicWall2"
@onready var magic_wall_4: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall4"
@onready var magic_wall_3: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall3"
@onready var magic_wall_5: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall5"
@onready var magic_wall_6: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall6"
@onready var magic_wall_7: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall7"
@onready var magic_wall_9: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall9"
@onready var magic_wall_10: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall10"
@onready var magic_wall_11: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall11"
@onready var magic_wall_12: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall12"
@onready var magic_wall_13: StaticBody2D = $"../WorldStuff/MagicWalls/MagicWall13"

#Knut Dialogue Nodes
@onready var knut_dialogue: Label = $"../HUD/DialogueHUD2/Panel/KnutDialogue"
@onready var knut_animiation: AnimatedSprite2D = $"../KNÜT/knutAnimiation"

#Particle Nodes
@onready var wall_jump_particles_left: GPUParticles2D = $WallJumpParticlesLeft
@onready var wall_jump_particles_right: GPUParticles2D = $WallJumpParticlesRight
@onready var double_jump_particles: CPUParticles2D = $DoubleJumpParticles
@onready var jump_particles: CPUParticles2D = $JumpParticles


#Tomes
@onready var tome_1: Area2D = $"../KNÜT/MysteriousTomes/Tome1"
@onready var tome_2: Area2D = $"../KNÜT/MysteriousTomes/Tome2"
@onready var tome_3: Area2D = $"../KNÜT/MysteriousTomes/Tome3"
@onready var tome_4: Area2D = $"../KNÜT/MysteriousTomes/Tome4"
@onready var tome_5: Area2D = $"../KNÜT/MysteriousTomes/Tome5"
@onready var tome_6: Area2D = $"../KNÜT/MysteriousTomes/Tome6"
@onready var tome_7: Area2D = $"../KNÜT/MysteriousTomes/Tome7"
@onready var tome_knowledge: Label = $"../HUD/DialogueHUD2/TomePanel/ScrollContainer/TomeKnowledge"
@onready var tome_panel: Panel = $"../HUD/DialogueHUD2/TomePanel"
@onready var take_button: Button = $"../HUD/DialogueHUD2/TakeButton"

#Tutorial Catalysts
@onready var tutorial_sprite_1: AnimatedSprite2D = $"../WorldStuff/TutorialCatalysts/TutorialCatlyst1/TutorialSprite1"
@onready var e_to_learn: Label = $"../HUD/DialogueHUD2/Panel/eToLearn"
@onready var tutorial_sprite_2: AnimatedSprite2D = $"../WorldStuff/TutorialCatalysts/TutorialCatalyst2/TutorialSprite2"


#Brain world
@onready var floating_platform: AnimationPlayer = $"../WorldStuff/GlobalPlatforms/BrainPlatform/floatingPlatform"


#Respawn catalysts
@onready var res_ice_sprite: AnimatedSprite2D = $"../Baltrude/ResIce/ResIceSprite"
@onready var res_fire_sprite: AnimatedSprite2D = $"../Baltrude/ResFire/ResFireSprite"
@onready var res_knut_sprite: AnimatedSprite2D = $"../Baltrude/ResKnut/ResKnutSprite"
@onready var res_marble_sprite: AnimatedSprite2D = $"../Baltrude/ResMarble/ResMarbleSprite"
@onready var res_dark_brick_sprite: AnimatedSprite2D = $"../Baltrude/ResDarkBrick/ResDarkBrickSprite"
@onready var res_end_game_sprite: AnimatedSprite2D = $"../Baltrude/ResEndGame/ResEndGameSprite"



func _ready() -> void:
	Engine.time_scale = 1.0
	playerAlive = true
	playerPaused = false
	
	if !GameState.LoadGameFlag && GameState.LoadMyGame:
		onLoadGame()
		
	respawn()
	hide_all_ui()
	play_idle_animations()
	
	floating_platform.play("RESET")

func _process(_delta: float) -> void:
	#Killzone death
	if Engine.time_scale < 1.0 and playerAlive:
		die()
	
	#Dialogue purposes
	dialogueCheck()
	#SwordChecker
	swordCheck()
	#Animations
	AnimationManager()
	#TutorialCheck
	tutorialCheck()
	#Pause Functions
	pauseCheck()
	#Respawn postioning check
	respawnLocationCheck()
	#HUD
	HudVisibility()
	
	shootProjectile()
	
func respawn():
	
	playerAlive = true
	setAnimation("Idle")
	
	if ResBalt:
		ResBalt = true
		position.x = 60
		position.y = 11
		
		
	elif ResIce:
		ResIce = true
		position.x = 1501
		position.y = 186
		
		
	elif ResFire:
		ResFire = true
		position.x = -50
		position.y = -500
		
	elif ResKnut:
		ResKnut = true
		position.x = 2337
		position.y = -516
	
	elif ResMarble:
		ResMarble = true
		position.x = -600
		position.y = 514
	
	elif ResDarkBrick:
		ResDarkBrick = true
		position.x = 3629
		position.y = 132
		
	elif ResEndGame:
		ResEndGame = true
		position.x = 1743
		position.y = -2659
		
	else:
		position.x = -434
		position.y = -1100

func die():
		
		you_died.visible = true
		print("you have died")
		death_timer.start()
		playerAlive = false

func HudVisibility():
	
	if baltrude_dialogue.visible == true:
		GameState.baltrudeTalking = true
		panel.visible = true
		q_to_talk.visible = false
		e_to_activate.visible = false
		knut_dialogue.visible = false
		e_to_take.visible = false
		e_to_learn.visible = false
		
	elif q_to_talk.visible == true:
		GameState.baltrudeTalking = false
		panel.visible = true
		baltrude_dialogue.visible = false
		e_to_activate.visible = false
		knut_dialogue.visible = false
		e_to_take.visible = false
		e_to_learn.visible = false
	
	elif knut_dialogue.visible == true:
		panel.visible = true
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		e_to_activate.visible = false
		knut_animiation.play("Talking")
		e_to_take.visible = false
		e_to_learn.visible = false
		
	elif e_to_activate.visible == true:
		panel.visible = true
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		knut_dialogue.visible = false
		e_to_take.visible = false
		e_to_learn.visible = false
		
		
	elif tutorial_text.visible == true:
		panel.visible = true
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		knut_dialogue.visible = false
		e_to_activate.visible = false
		e_to_take.visible = false
		e_to_learn.visible = false
		
	elif tome_knowledge.visible == true:
		panel.visible = false
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		knut_dialogue.visible = false
		e_to_activate.visible = false
		tutorial_text.visible = false
		e_to_take.visible = false
		e_to_learn.visible = false
		
	elif e_to_take.visible == true:
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		knut_dialogue.visible = false
		e_to_activate.visible = false
		tutorial_text.visible = false
		tome_knowledge.visible = false
		e_to_learn.visible = false
		
	elif e_to_learn.visible == true:
		baltrude_dialogue.visible = false
		q_to_talk.visible = false
		knut_dialogue.visible = false
		e_to_activate.visible = false
		tutorial_text.visible = false
		tome_knowledge.visible = false
		e_to_take.visible = false
		
	else:
		panel.visible = false
		knut_animiation.play("Idle")

func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1.0
	you_died.visible = false
	respawn()

func _on_baltrude_body_entered(_body = CharacterBody2D) -> void:
	
	inRangeBalt = true
	
	baltrude_dialogue.visible = false
	
	q_to_talk.visible = true
	q_to_talk.text = "Press Q to talk"
	
	
	
	if fireCatalystCollected and iceCatalystCollected:
		print("Another? This cannot be! oh no... oh my.")
		print("I must really be losing track of myself these days.")

func _on_baltrude_body_exited(_body: CharacterBody2D) -> void:
	inRangeBalt = false
	baltrude_dialogue.visible = false
	q_to_talk.visible = false

func _on_ice_catalyst_body_entered(_body = CharacterBody2D) -> void:
	GameState.IceCatalystCollected = true
	iceCatalystCollected = true
	baltrude_dialogue.visible = true
	baltrude_dialogue.text = "You have found my core Catalyst, return to me at once!"
	return_timer.start()
	if GameState.IceCatalystCollected and !GameState.IceCatalystCollectedFlag:
		GameState.IceCatalystCollectedFlag = true
		ice_catalyst.queue_free()
		magic_wall_2.queue_free()
		magic_wall_1.queue_free()
		elevator_one.play("Elevator")
		platform_12.visible = true
		GameState.itemsCollected.append("iceCatalyst")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if !is_on_floor():
		if velocity.y > 0:
			velocity += get_gravity() * FALL_MULTIPLIER * delta
		else:
			velocity += get_gravity() * delta
	
	#Gets the input code for direction: 1, 0, -1.
	var direction  = 0
	if playerAlive and !playerPaused:
		direction = Input.get_axis("move_left", "move_right")
	else:
		direction = 0
		
	#Applies the Movment
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
	
	#Buffer timer
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()
	
	# Handle jump.
	if (Input.is_action_just_pressed("jump") && playerAlive) && (is_on_floor() || !coyote_timer.is_stopped()): #and shellMode == true:
		if !jump_buffer.is_stopped():
			velocity.y = jumpVelocity
	
	#Adds variable jump
	if Input.is_action_just_released("jump"):
		velocity.y *= 0.4
	
	#Adds fall through platform
	if is_on_floor() and Input.is_action_just_pressed("Drop") and ray_cast_bottom.is_colliding():
		position.y += 1
		
	if fireCatalystCollected:
		if ((!is_on_floor() and !is_on_wall()) or !coyote_timer.is_stopped()) and Input.is_action_just_pressed("jump") and doubleJump == false:
			velocity.y = jumpVelocity
			animated_sprite.play("Falling")
			doubleJump = true
		if is_on_floor() or is_on_wall():
			doubleJump = false
	
	#WALL JUMPS
	if ray_cast_left.is_colliding() or ray_cast_right.is_colliding():
		velocity.y *= .7
	
	#This allows for only a wall jump to be used on a right or left wall once until reset.
	if iceCatalystCollected:
		var wall_direction = 0
		if Input.is_action_just_pressed("jump") and (is_on_wall() or !wall_coyote_timer_2.is_stopped()):
			if ray_cast_left.is_colliding() and not leftWallJumpUsed:
				wall_direction = 1
				leftWallJumpUsed = true
				rightWallJumpUsed = false
			elif ray_cast_right.is_colliding() and not rightWallJumpUsed:
				wall_direction = -1
				rightWallJumpUsed = true
				leftWallJumpUsed = false
		if wall_direction != 0:
			if direction != 0:
				velocity.x = WALK_SPEED * 2 * wall_direction
			else:
				velocity.x = WALK_SPEED * 1 * wall_direction
			velocity.y = jumpVelocity
			if direction == 1:
				wall_jump_particles_left.restart()
			elif direction == -1:
				wall_jump_particles_right.restart()
	
	#resets our wall jump
	if is_on_floor() and iceCatalystCollected:
		rightWallJumpUsed = false
		leftWallJumpUsed = false
	
	#coyote timer
	var wasOnFloor = is_on_floor()
	var wasOnWall = is_on_wall()
	
	move_and_slide()
	
	if wasOnFloor && !is_on_floor():
		coyote_timer.start()
	if wasOnWall && !is_on_wall():
		wall_coyote_timer_2.start()

func _on_return_timeout() -> void:
	baltrude_dialogue.visible = false
	story = 11

func _on_down_there_timer_timeout() -> void:
	baltrude_dialogue.visible = false
	panel.visible = false

func baltrudeDialogue():
	
	if q_to_talk.visible == true:
		baltrude_dialogue.visible = false
	
	if inRangeBalt and Input.is_action_just_pressed("Talk"):
		GameState.StoryProgress = story
		q_to_talk.visible = false
		baltrude_dialogue.visible = true
		respawnLocation = 0
		ResBalt = true
		ResIce = false
		ResKnut = false
		ResFire = false
	
	#First meeting dialogue
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 0:
		baltrude_dialogue.text = "Who are you?"
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 1:
		baltrude_dialogue.text = "You don't even know who you are do you?"
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 2:
		baltrude_dialogue.text = "I ... uhhh ... I am ... Do you know who I am?"
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 3:
		baltrude_dialogue.text = "My sweet Adeline can help us. It will come back to me."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 4:
		baltrude_dialogue.text = " Now that you are here, I could actually really use your help."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 5:
		baltrude_dialogue.text = "I have been trapped for years in this castle. My wife is around here somewhere ... can you help us?"
		dialogue_timer_intro.start()
		
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 6:
		baltrude_dialogue.text = " ... Hold on. What are you? A peanut?"
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 7:
		baltrude_dialogue.text = "Hmmm ... Strange ... and where did you say you come from?"
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 8:
		baltrude_dialogue.text = "Anyways, you will need help. These halls are filled with all kinds of magic."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 9:
		baltrude_dialogue.text = "If you find any artifacts, bring them to me at once."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 10:
		baltrude_dialogue.text = "Now go, find a way out. My legs don't work ... so I won't be far."
		
	
	
	
	
	#Ice catalyst collected Dialogue.
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 11:
		baltrude_dialogue.text = "An Ice Catalyst you say ... let me take a look."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 12:
		baltrude_dialogue.text ="I didn't think I would see one of these again."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 13:
		baltrude_dialogue.text ="This catalyst comes from my home. Catalysts like these were made duing the war."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 14:
		baltrude_dialogue.text ="To help you traverse the castle, if you are wallsliding, you can now jump off walls."
		dialogue_timer_intro.start()
		
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 15:
		baltrude_dialogue.text ="This is a powerful artifact. If you find more bring them to me."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 16:
		baltrude_dialogue.text ="Are you sure we do not know eachother? It seems both of our minds have failed us."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 17:
		baltrude_dialogue.text = "... It is a shame. If you see my wife Adeline, please tell her to find me."
		
		
		
		#FireCatalyst Collected Dialogue
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 18:
		baltrude_dialogue.text = "Oh ... Oh no ... I do not want that, take it away please."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 19:
		baltrude_dialogue.text = "That is a fire catalyst ... A vile creation."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 20:
		baltrude_dialogue.text = "I shall bestow its power onto but at a terrible cost."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 21:
			baltrude_dialogue.text = "These were used to detroyed me and Adelines home, The Glacial Vale."
			dialogue_timer_intro.start()
			
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 22:
		baltrude_dialogue.text = "Have you still not seen her? Have you met anyone? What sort of mysterys do our minds block us from seeing?"
		dialogue_timer_intro.start()
			
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 23:
			baltrude_dialogue.text = "Just know ... these halls are cruel and cannot sustain life..."
			dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 24:
		baltrude_dialogue.text = "Those dwelling here, are wandering souls. My mind is old and faltering but you, you are young."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 25:
		baltrude_dialogue.text = "I need you to promise that you will get me out of these halls..."
		dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 26:
			baltrude_dialogue.text = "Hand me that vial there, will you?"
			dialogue_timer_intro.start()
		
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 27:
		baltrude_dialogue.text = "You mustn't get too near to the ghouls and beasts *BURP* that wrethced Aelfric."
		dialogue_timer_intro.start()
	
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 28:
		baltrude_dialogue.text = " ... I have made so many mistakes ... Oh my Adeline ... I can't bear to wander these halls anymore... please..."
		dialogue_timer_intro.start()
	
	if inRangeBalt and Input.is_action_just_pressed("Talk") and story == 29:
		baltrude_dialogue.text = "Alefric ... you ... please little Peanut, if you find that man ... kill him."



	if !inRangeBalt && !inRangeKnut:
		knut_dialogue.visible = false
		baltrude_dialogue.visible = false
		panel.visible = false
		q_to_talk.visible = false

func knutDialogue():
	if q_to_talk.visible == true:
		baltrude_dialogue.visible = false
		knut_dialogue.visible = false
	
	if inRangeKnut and Input.is_action_just_pressed("Talk"):
		q_to_talk.visible = false
		knut_dialogue.visible = true
		GameState.SideStoryProgress = sideStory
	
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 0:
		knut_dialogue.text = "Umm... who are you?"
		dialogue_timer_intro.start()
	
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 1:
		knut_dialogue.text = "... wait... what are you?"
		dialogue_timer_intro.start()
	
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 2:
		knut_dialogue.text = "Oh man... you must be Baltrude's latest victim, huh?"
		dialogue_timer_intro.start()
	
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 3:
		knut_dialogue.text = "Sheesh, he really is losing it."
		dialogue_timer_intro.start()
	
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 4:
		knut_dialogue.text = "I'm guessing you've met his son then?"
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 5:
		knut_dialogue.text = "Oh? You haven't?"
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 6:
		knut_dialogue.text = "Who is taking care of him then?"
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 7:
		knut_dialogue.text = "Do me a favor, do not listen to his ramblings..."
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 8:
		knut_dialogue.text = "In fact, have you found any of his tomes laying around?"
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 9:
		knut_dialogue.text = "If you bring those to me, I will reward you."
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 10:
		knut_dialogue.text = "I will tell you everything I know about the man."
		dialogue_timer_intro.start()
		
	if inRangeKnut and Input.is_action_just_pressed("Talk") and sideStory == 11:
		knut_dialogue.text = "Oh, and do me a favor. Don't tell him you saw me."
		helpingKnut = true
		magic_wall_3.visible = false
		magic_wall_5.visible = false
		magic_wall_6.visible = false
		magic_wall_7.visible = false

func Story():
	story = story +1
	
func SideQuest():
	sideStory = sideStory +1

#Ice Catalyst Respawn
func _on_res_ice_body_entered(_body: Node2D) -> void:
	
	inRangeIce = true

func _on_res_ice_body_exited(_body: Node2D) -> void:
	
	inRangeIce = false

#Fire Catalyst Respawn
func _on_res_fire_body_entered(_body: Node2D) -> void:
	
	inRangeFire = true

func _on_res_fire_body_exited(_body: Node2D) -> void:
	inRangeFire = false

#Fire catalyst collection and double jump aqquisition 
func _on_fire_catalyst_body_entered(_body: Node2D) -> void:
	GameState.FireCatalystCollected = true
	return_2.start()
	baltrude_dialogue.visible = true
	baltrude_dialogue.text = "That's my boy! Please return at once."
	if GameState.FireCatalystCollected and GameState.FireCatalystCollectedFlag == false:
		GameState.FireCatalystCollectedFlag = true
		elevator_two.play("Rise")
		fire_catalyst.queue_free()
		magic_wall_4.queue_free()
		magic_wall_9.queue_free()
		story = 16
		GameState.itemsCollected.append("fireCatalyst")
	
func _on_return_2_timeout() -> void:
	baltrude_dialogue.visible = false

#Knut Functions
func _on_knüt_body_entered(_body: Node2D) -> void:
	inRangeKnut = true
	
	q_to_talk.visible = true

func _on_knüt_body_exited(_body: Node2D) -> void:
	inRangeKnut = false
	
	q_to_talk.visible = false

func _on_res_knut_body_entered(_body: Node2D) -> void:
	inResRangeKnut = true

func _on_res_knut_body_exited(_body: Node2D) -> void:
	inResRangeKnut = false

func _on_take_button_pressed() -> void:
	tome_panel.visible = false
	tome_knowledge.visible = false
	take_button.visible = false

#Tome Checking Functions
func _on_tome_1_body_entered(_body: Node2D) -> void:
	GameState.TomeOneCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "July 17th, 1055  - 
	What a glorious castle Adeline and I have found ourselves in. Legends speak of Orm the Ruler, and the Golden Age. We have set out on a quest to find an artifact said to have belonged to Aed the Disciple of Light and Dark. These halls are said to be endless. My dear Adeline is here with me to guide me with her glorious wisdom. She will give birth to our child in the coming months, We must find our prize quick and return home.
	- Baltrude"
	take_button.visible = true
	panel.visible = false
	tome_1.queue_free()
	magic_wall_12.queue_free()
	GameState.itemsCollected.append("entryOne")

func _on_tome_2_body_entered(_body: Node2D) -> void:
	GameState.TomeTwoCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "July 18th, 1055 - I have underestimated the rumors of this castle. We should have never come here. No magic is worth the sacrifices we have made. We are close to the exit, but the riddles written by these walls are cruel and unusual.
	- Baltrude"
	take_button.visible = true
	panel.visible = false
	tome_2.queue_free()
	magic_wall_13.queue_free()
	GameState.itemsCollected.append("entryTwo")

func _on_tome_3_body_entered(_body: Node2D) -> void:
	GameState.TomeThreeCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "August 3rd, 1055 - Months have now passed. Adeline has given birth to a glorious son ... What a terrible place to grow up. I wish to show him the world. I fear he will become quite familiar with the marking on the walls. The birth was too much for Adeline. She has grown quite sick. I fear for her ... I cannot do this without her. I must find a way out.
	- Baltrude"
	take_button.visible = true
	panel.visible = false
	tome_3.queue_free()
	magic_wall_10.queue_free()
	GameState.itemsCollected.append("entryThree")

func _on_tome_4_body_entered_(_body: Node2D) -> void:
	GameState.TomeFourCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "Feburary 20th, 1056 - 
	Oh Adeleine ... The sickness has spread through her in such a diabolic way. She has begun to forget me ... I do not even recognize her anymore. I fear that soon I must resort to a dark magic. I must protect her mind, but I fear it is too far gone. Oh Aelfric, our poor, beautiful son. He is too young to understand. I will teach him everything. If I cannot get out, hopefully at least he can.
	- Baltrude"
	take_button.visible = true
	panel.visible = false
	GameState.itemsCollected.append("entryFour")
	tome_4.queue_free()
	magic_wall_11.queue_free()

func _on_tome_5_body_entered(_body: Node2D) -> void:
	GameState.TomeFiveCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "September 17th, 1061 - 
	I miss my Adeline ... Aelfric's face reminds me so much of her. I cannot bear to look at him. He is now five years old. His life was too much for Adeline to support. I must not blame him for her death but it is hard. He is just a boy. I have begun biologic experimentations. I have kept her flesh alive, feeding them bits of magics. I fear I must begin testing on the same creature we have resorted to eating. There are creatures in this castle that no god has made.
	-Baltrude"
	GameState.itemsCollected.append("entryFive")
	tome_5.queue_free()

func _on_tome_6_body_entered(_body: Node2D) -> void:
	GameState.TomeSixCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "June 27th, 1075 - 
	This boy keep telling about his father, Baltrude. He tells me today marks his 19th birthday. Disgusting creature, he is. I don't even remeber my age. He tells me, that my mind has begun to go and that he wants help me. When I look at this young man I am overswept with hatred. These feelings come from deep inside and I do not understand them. I do not care for his ramblings. My beautiful Adeline teeters on the brim of life and death. I am so close to bringing her back. She is all I want. I want to show her my home. I want to show her this beautiful castle I have built for her. The potion is so close, I have been brewing it for years now.
	- ... "
	GameState.itemsCollected.append("entrySix")
	tome_6.queue_free()

func _on_tome_7_body_entered(_body: Node2D) -> void:
	GameState.TomeSevenCollected = true
	tome_panel.visible = true
	tome_knowledge.visible = true
	tome_knowledge.text = "September 22nd, 1075 - 
	Gone ... it is all gone. That boy ruined it all. Adeline was basically back and Aelfric ruined it. In an act of pure destruction he destroyed my potion. He shall pay for his actions."
	GameState.itemsCollected.append("entrySeven")
	tome_7.queue_free()

#SwordChecking functions
func _on_sword_artifact_body_entered(_body: Node2D) -> void:
	panel.visible = true
	e_to_take.visible = true
	e_to_take.text = "Press E to try to remove the sword"
	swordInRange = true

func _on_sword_artifact_body_exited(_body: Node2D) -> void:
	swordInRange = false
	panel.visible = false
	e_to_take.visible = false

func swordInTheStoneAttempt():
	
		if !iceCatalystCollected and !fireCatalystCollected:
			e_to_take.text = "You are not worthy ..."
		
		elif iceCatalystCollected and !fireCatalystCollected:
			e_to_take.text = "Still not worthy ..."
		
		elif iceCatalystCollected and fireCatalystCollected:
			e_to_take.text = "Goodness, you have done it ... You ARE worthy."
			sword_timer.start()

func _on_sword_timer_timeout() -> void:
	panel.visible = false
	e_to_take.visible = false
	sword.visible = true
	sword_artifact.queue_free()
	GameState.itemsCollected.append("sword")

func Attack():
	if sword_sprite_left.visible == true:
		left_swing.play("LeftSwing")
	elif sword_sprite_right.visible == true:
		right_swing.play("RightSwing")

#Tutorial Catalysts
func _on_tutorial_catlyst_1_body_entered(_body: Node2D) -> void:
	inRangeCatalystOne = true
	panel.visible = true
	e_to_learn.visible = true
	e_to_learn.text = "Press E to learn"

func _on_tutorial_catlyst_1_body_exited(_body: Node2D) -> void:
	inRangeCatalystOne = false
	panel.visible = false
	tutorial_text.visible = false
	e_to_learn.visible = false
	tutorial_sprite_1.play("Unactivated")

func _on_tutorial_catalyst_2_body_entered(_body: Node2D) -> void:
	inRangeCatalystTwo = true
	panel.visible = true
	e_to_learn.visible = true
	e_to_learn.text = "Press E to learn"

func _on_tutorial_catalyst_2_body_exited(_body: Node2D) -> void:
	inRangeCatalystTwo = false
	panel.visible = false
	tutorial_text.visible = false
	e_to_learn.visible = false
	tutorial_sprite_2.play("Unactivated")

func hide_all_ui():
	you_died.visible = false
	panel.visible = false
	baltrude_dialogue.visible = false
	hud.visible = true
	e_to_activate.visible = false
	tutorial_text.visible = false
	tome_knowledge.visible = false
	tome_panel.visible = false
	take_button.visible = false
	sword_sprite_left.visible = false
	sword_sprite_right.visible = true
	e_to_take.visible = false
	elevator_one.pause()
	elevator_two.pause()
	platform_12.visible = false

func play_idle_animations():
	tutorial_sprite_1.play("Unactivated")
	tutorial_sprite_2.play("Unactivated")

func onLoadGame():
		GameState.LoadGameFlag = true
		
		story = GameState.StoryProgress
		
		sideStory = GameState.SideStoryProgress
		
		if GameState.IceCatalystCollected == true:
			iceCatalystCollected = true
			ice_catalyst.queue_free()
			magic_wall_2.queue_free()
			magic_wall_1.queue_free()
			elevator_one.play("Elevator")
			platform_12.visible = true
			GameState.itemsCollected.append("iceCatalyst")
		
		if GameState.FireCatalystCollected == true:
			fireCatalystCollected = true
			elevator_two.play("Rise")
			fire_catalyst.queue_free()
			magic_wall_4.queue_free()
			magic_wall_9.queue_free()
			story = 16
			GameState.itemsCollected.append("fireCatalyst")
		
		if GameState.TomeOneCollected:
			TomeOneCollected = true
			tome_1.queue_free()
			magic_wall_12.queue_free()
			GameState.itemsCollected.append("entryOne")
		
		if GameState.TomeTwoCollected:
			TomeTwoCollected = true
			tome_2.queue_free()
			magic_wall_13.queue_free()
			GameState.itemsCollected.append("entryTwo")
		
		if GameState.TomeThreeCollected:
			TomeThreeCollected = true
			tome_3.queue_free()
			magic_wall_10.queue_free()
			GameState.itemsCollected.append("entryThree")
		
		if GameState.TomeFourCollected:
			TomeFourCollected = true
			GameState.itemsCollected.append("entryFour")
			tome_4.queue_free()
			magic_wall_11.queue_free()
		
		if GameState.TomeFiveCollected:
			TomeFiveCollected = true
			GameState.itemsCollected.append("entryFive")
			tome_5.queue_free()
		
		if GameState.TomeSixCollected:
			TomeSixCollected = true
			GameState.itemsCollected.append("entrySix")
			tome_6.queue_free()
		
		if GameState.TomeSevenCollected:
			TomeSevenCollected = true
			GameState.itemsCollected.append("entrySeven")
			tome_7.queue_free()
		
		if GameState.HelpingKnut:
			helpingKnut = true
			magic_wall_3.queue_free()
			magic_wall_5.queue_free()
			magic_wall_6.queue_free()
			magic_wall_7.queue_free()
		
		if GameState.SwordCollected:
			sword.visible = true
			sword_artifact.queue_free()
		
		if GameState.ResBalt:
			ResBalt = true
			position.x = 60
			position.y = 11
			res_fire_sprite.play("Death")
			res_ice_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
			
		if GameState.ResIce:
			ResIce = true
			position.x = 1501
			position.y = 186
			res_ice_sprite.play("Life")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
		
		if GameState.ResFire:
			ResFire = true
			position.x = -50
			position.y = -500
			res_fire_sprite.play("life")
			res_ice_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
			
		if GameState.ResKnut:
			ResKnut = true
			position.x = 2337
			position.y = -516
			res_knut_sprite.play("Life")
			res_fire_sprite.play("Death")
			res_ice_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
			
		if GameState.ResMarble:
			ResMarble = true
			position.x = -600
			position.y = 514
			res_knut_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_ice_sprite.play("Death")
			res_marble_sprite.play("Life")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
		
		if GameState.ResDarkBrick:
			ResDarkBrick = true
			position.x = 3629
			position.y = 132
			res_knut_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_ice_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Life")
			res_end_game_sprite.play("Death")
		
		if GameState.ResEndGame:
			ResEndGame = true
			position.x = 1743
			position.y = -2659
			res_knut_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_ice_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Life")

func AnimationManager():
	
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("jump"):
		jump_particles.emitting = true
	
	if Input.is_action_just_pressed("jump") && !is_on_floor():
		double_jump_particles.emitting = true
	
	if direction == 1:
		lastDirection = 1
	elif direction == -1:
		lastDirection = -1
		
	
	if !playerPaused && playerAlive:
		if direction == -1:
			setFlip(-1)
		elif direction == 1:
			setFlip(1)
	
	#Plays idle and walking animations.
	if !playerPaused && playerAlive && is_on_floor():
		if direction == 0:
			setAnimation("Idle")
		elif !direction == 0:
			setAnimation("Walking")
		
	
	elif !playerPaused && playerAlive && !is_on_floor():
		if ray_cast_left.is_colliding() || ray_cast_right.is_colliding():
			if (direction == 0 && lastDirection == -1) || direction == -1:
				setAnimation("Sliding_left")
				animated_sprite.flip_h = true
			elif (direction == 0 && lastDirection == 1) || direction == 1:
				setAnimation("Sliding_left")
				animated_sprite.flip_h = false
		else:
			setAnimation("Falling")
	
	#plays the death animation.
	elif !playerPaused && !playerAlive:
		setAnimation("Death")
	
	
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

func respawnLocationCheck():
	#GameState Updater
	if ResBalt:
		GameState.ResBalt = true
		GameState.ResIce = false
		GameState.ResFire = false
		GameState.ResKnut = false
		GameState.ResMarble = false
		GameState.ResDarkBrick = false
		GameState.ResEndGame = false
	elif ResIce:
		GameState.ResBalt = false
		GameState.ResIce = true
		GameState.ResFire = false
		GameState.ResKnut = false
		GameState.ResMarble = false
		GameState.ResDarkBrick = false
		GameState.ResEndGame = false
	elif ResFire:
		GameState.ResBalt = false
		GameState.ResIce = false
		GameState.ResFire = true
		GameState.ResKnut = false
		GameState.ResMarble = false
		GameState.ResDarkBrick = false
		GameState.ResEndGame = false
	elif ResKnut:
		GameState.ResBalt = false
		GameState.ResIce = false
		GameState.ResFire = false
		GameState.ResKnut = true
		GameState.ResMarble = false
		GameState.ResDarkBrick = false
		GameState.ResEndGame = false
	elif ResMarble:
		GameState.ResBalt = false
		GameState.ResIce = false
		GameState.ResFire = false
		GameState.ResKnut = false
		GameState.ResMarble = true
		GameState.ResDarkBrick = false
		GameState.ResEndGame = false
	elif ResDarkBrick:
		GameState.ResBalt = false
		GameState.ResIce = false
		GameState.ResFire = false
		GameState.ResKnut = false
		GameState.ResMarble = false
		GameState.ResDarkBrick = true
		GameState.ResEndGame = false
	elif ResEndGame:
		GameState.ResBalt = false
		GameState.ResIce = false
		GameState.ResFire = false
		GameState.ResKnut = false
		GameState.ResMarble = false
		GameState.ResDarkBrick = false
		GameState.ResEndGame = true
		
	
	#Respawn flags
	if inRangeIce && !ResIce:
		e_to_activate.visible = true
		baltrude_dialogue.visible = false
		if Input.is_action_just_pressed("activate_catalyst"):
			ResIce = true
			ResBalt = false
			ResKnut = false
			ResFire = false
			ResMarble = false
			ResDarkBrick = false
			ResEndGame = false
			e_to_activate.visible = false
			ResIce = true
			res_ice_sprite.play("Life")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
			
	else:
		e_to_activate.visible = false
	
	if inRangeFire  && !ResFire:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			ResFire = true
			ResIce = false
			ResBalt = false
			ResKnut = false
			ResMarble = false
			ResDarkBrick = false
			ResEndGame = false
			res_ice_sprite.play("Death")
			res_fire_sprite.play("Life")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
	
	if inResRangeKnut && !ResKnut:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			ResKnut = true
			ResIce = false
			ResBalt = false
			ResFire = false
			ResMarble = false
			ResDarkBrick = false
			ResEndGame = false
			res_ice_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Life")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
	
	if inResRangeMarble && !ResMarble:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			ResKnut = false
			ResIce = false
			ResBalt = false
			ResFire = false
			ResMarble = true
			ResDarkBrick = false
			ResEndGame = false
			res_ice_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Life")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Death")
	
	if inResRangeDarkBrick && !ResDarkBrick:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			ResKnut = false
			ResIce = false
			ResBalt = false
			ResFire = false
			ResMarble = false
			ResDarkBrick = true
			ResEndGame = false
			res_ice_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Life")
			res_end_game_sprite.play("Death")
	
	if inResRangeEndGame && ! ResEndGame:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			ResKnut = false
			ResIce = false
			ResBalt = false
			ResFire = false
			ResMarble = false
			ResDarkBrick = false
			ResEndGame = true
			res_ice_sprite.play("Death")
			res_fire_sprite.play("Death")
			res_knut_sprite.play("Death")
			res_marble_sprite.play("Death")
			res_dark_brick_sprite.play("Death")
			res_end_game_sprite.play("Life")

func pauseCheck():
	#paused mechanics for player (including some dialogue nonsesense)
	if get_tree().paused == true:
		playerPaused = true
	else:
		playerPaused = false
		camera_2d.zoom = Vector2(7,7)
	
	if playerPaused:
		camera_2d.zoom = Vector2(9,9)
		jumpVelocity = 0
		baltrude_dialogue.visible = false
		knut_dialogue.visible = false
		panel.visible = false
		animated_sprite.play("Pause Screen")
		e_to_activate.visible = false
		q_to_talk.visible = false
	else: 
		camera_2d.zoom = Vector2(7,7)
		jumpVelocity = -275.0

func tutorialCheck():
	if inRangeCatalystOne and Input.is_action_pressed("activate_catalyst"):
		e_to_learn.visible = false
		tutorial_sprite_1.play("Activated")
		tutorial_text.visible = true
		tutorial_text.text = "Use WASD To move and jump."
		
	if inRangeCatalystTwo and Input.is_action_just_pressed("activate_catalyst"):
		e_to_learn.visible = false
		tutorial_sprite_2.play("Activated")
		tutorial_text.visible = true
		tutorial_text.text = "Jump onto a wall to wallslide."

func swordCheck():
	if Input.is_action_pressed("activate_catalyst") and swordInRange:
		swordInTheStoneAttempt()
	if Input.is_action_pressed("Attack"):
		Attack()

func dialogueCheck():
	if inRangeBalt:
		baltrudeDialogue()
	if inRangeKnut:
		knutDialogue()
	
	GameState.StoryProgress = story
	
	GameState.SideStoryProgress = sideStory

func _on_start_trigger_body_entered(_body: Node2D) -> void:
	floating_platform.play("FloatingPlatform")

func _on_res_marble_body_entered(_body: Node2D) -> void:
	inResRangeMarble = true

func _on_res_marble_body_exited(_body: Node2D) -> void:
	inResRangeMarble = false

func _on_res_dark_brick_body_entered(_body: Node2D) -> void:
	inResRangeDarkBrick = true

func _on_res_dark_brick_body_exited(_body: Node2D) -> void:
	inResRangeDarkBrick = false

func _on_res_end_game_body_entered(_body: Node2D) -> void:
	inResRangeEndGame = true

func _on_res_end_game_body_exited(_body: Node2D) -> void:
	inResRangeEndGame = false

func setAnimation(animName : String):
	if animated_sprite.animation != animName:
		animated_sprite.play(animName)

func setFlip(direction : int):
	var shouldFlip := direction == -1
	if animated_sprite.flip_h != shouldFlip:
		animated_sprite.flip_h = shouldFlip

func shootProjectile():
	if Input.is_action_just_pressed("Attack"):
		var playerProjectile = projectile_scene.instantiate()
		get_tree().current_scene.add_child(playerProjectile)
		playerProjectile.global_position = shootPoint.global_position
		
		if animated_sprite.flip_h == false:
			playerProjectile.set_velocity(Vector2.RIGHT * projectileSpeed)
		else:
			playerProjectile.set_velocity(Vector2.LEFT * projectileSpeed)
			

func _on_dialogue_timer_intro_timeout() -> void:
	if inRangeBalt:
		Story()
	elif inRangeKnut:
		SideQuest()
