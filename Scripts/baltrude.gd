extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite


func _ready() -> void:
	setAnimation("Idle")



func _process(_delta: float) -> void:
	if GameState.baltrudeTalking == true:
		setAnimation("Talking")
	
	else:
		setAnimation("Idle")
	
	
	


func setAnimation(animName : String):
	if animated_sprite.animation != animName:
		animated_sprite.play(animName)
