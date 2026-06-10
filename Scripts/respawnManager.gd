extends Area2D


#Respawn manager on ready variables
@onready var res_ice_sprite: AnimatedSprite2D = $ResIceSprite
@onready var res_fire_sprite: AnimatedSprite2D = $"../ResFire/ResFireSprite"
@onready var res_knut_sprite: AnimatedSprite2D = $"../ResKnut/ResKnutSprite"
@onready var res_marble_sprite: AnimatedSprite2D = $"../ResMarble/ResMarbleSprite"
@onready var res_dark_brick_sprite: AnimatedSprite2D = $"../ResDarkBrick/ResDarkBrickSprite"
@onready var res_end_game_sprite: AnimatedSprite2D = $"../ResEndGame/ResEndGameSprite"
@onready var e_to_activate: Label = $"../../HUD/DialogueHUD2/Panel/eToActivate"



#Respawn variables
var inRangeResIce = false
var inRangeResFire = false
var inRangeResKnut = false
var inRangeResMarble = false
var inRangeResDarkBrick = false
var inRangeResEndGame = false


func _ready() -> void:
	newGame()

func _process(_delta: float) -> void:
	if inRangeResIce && !GameState.ResIce:
		e_to_activate.visible = true
		if Input.is_action_just_pressed("activate_catalyst"):
			GameState.ResIce = true

func newGame():
	res_ice_sprite.play("Death")
	res_fire_sprite.play("Death")
	res_knut_sprite.play("Death")
	res_marble_sprite.play("Death")
	res_dark_brick_sprite.play("Death")
	res_end_game_sprite.play("Death")


func _on_body_entered(_body: Node2D) -> void:
	inRangeResIce = true


func _on_body_exited(_body: Node2D) -> void:
	inRangeResIce = false
