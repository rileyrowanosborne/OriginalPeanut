extends CanvasLayer

@onready var you_died: Label = $DialogueHUD/YouDied
@onready var q_to_talk: Label = $DialogueHUD/Panel/qToTalk
@onready var panel: Panel = $DialogueHUD/Panel
@onready var hud: CanvasLayer = $"."
@onready var dialogue_hud: Control = $DialogueHUD
@onready var baltrude_dialogue: Label = $DialogueHUD/Panel/BaltrudeDialogue
@onready var knut_dialogue: Label = $DialogueHUD/Panel/KnutDialogue
@onready var e_to_activate: Label = $DialogueHUD/Panel/eToActivate





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if GameState.inRangeBaltrude:
		panel.visible = true
		
		if baltrude_dialogue.visible == false:
			q_to_talk.visible = true
		elif baltrude_dialogue.visible == true:
			q_to_talk.visible = false
			
		
	elif !GameState.inRangeBaltrude:
		panel.visible = false
		q_to_talk.visible = false
		baltrude_dialogue.visible = false
