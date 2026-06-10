extends Control


@onready var dialogue_timer: Timer = $DialogueTimerIntro



var story := 0

func _process(_delta: float) -> void:
	BaltrudeDialogueShit()




func BaltrudeDialogueShit():
	
	if Hud.q_to_talk.visible == true:
		Hud.baltrude_dialogue.visible = false
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk"):
		Hud.q_to_talk.visible = false
		Hud.baltrude_dialogue.visible = true
	
	#First meeting dialogue
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 0:
		Hud.baltrude_dialogue.text = "Wait, uhhhhh, who are you?"
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 1:
		Hud.baltrude_dialogue.text = "You don't even know who you are do you?"
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 2:
		Hud.baltrude_dialogue.text = "I ... uhhh ... I am ... Do you know who I am?"
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 3:
		Hud.baltrude_dialogue.text = "My sweet Adeline can help us. It will come back to me."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 4:
		Hud.baltrude_dialogue.text = " Now that you are here, I could actually really use your help."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 5:
		Hud.baltrude_dialogue.text = "I have been trapped for years in this castle. My wife is around here somewhere ... can you help us?"
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 6:
		Hud.baltrude_dialogue.text = " ... Hold on. What are you? A peanut?"
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 7:
		Hud.baltrude_dialogue.text = "Hmmm ... Strange ... and where did you say you come from?"
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 8:
		Hud.baltrude_dialogue.text = "Anyways, you will need help. These halls are filled with all kinds of magic."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 9:
		Hud.baltrude_dialogue.text = "If you find any artifacts, bring them to me at once."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 10:
		Hud.baltrude_dialogue.text = "Now go, find a way out. My legs don't work ... so I won't be far."
		
	
	#Ice catalyst collected Dialogue.
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 11:
		Hud.baltrude_dialogue.text = "An Ice Catalyst you say ... let me take a look."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 12:
		Hud.baltrude_dialogue.text ="I didn't think I would see one of these again."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 13:
		Hud.baltrude_dialogue.text ="This catalyst comes from my home. Catalysts like these were made duing the war."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 14:
		Hud.baltrude_dialogue.text ="To help you traverse the castle, if you are wallsliding, you can now jump off walls."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 15:
		Hud.baltrude_dialogue.text ="This is a powerful artifact. If you find more bring them to me."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 16:
		Hud.baltrude_dialogue.text ="Are you sure we do not know eachother? It seems both of our minds have failed us."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 17:
		Hud.baltrude_dialogue.text = "... It is a shame. If you see my wife Adeline, please tell her to find me."
		
		
	#FireCatalyst Collected Dialogue
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 18:
		Hud.baltrude_dialogue.text = "Oh ... Oh no ... I do not want that, take it away please."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 19:
		Hud.baltrude_dialogue.text = "That is a fire catalyst ... A vile creation."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 20:
		Hud.baltrude_dialogue.text = "I shall bestow its power onto but at a terrible cost."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 21:
		Hud.baltrude_dialogue.text = "These were used to detroyed me and Adelines home, The Glacial Vale."
		dialogue_timer.start()
			
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 22:
		Hud.baltrude_dialogue.text = "Have you still not seen her? Have you met anyone? What sort of mysterys do our minds block us from seeing?"
		dialogue_timer.start()
			
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 23:
		Hud.baltrude_dialogue.text = "Just know ... these halls are cruel and cannot sustain life..."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 24:
		Hud.baltrude_dialogue.text = "Those dwelling here, are wandering souls. My mind is old and faltering but you, you are young."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 25:
		Hud.baltrude_dialogue.text = "I need you to promise that you will get me out of these halls..."
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 26:
		Hud.baltrude_dialogue.text = "Hand me that vial there, will you?"
		dialogue_timer.start()
		
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 27:
		Hud.baltrude_dialogue.text = "You mustn't get too near to the ghouls and beasts *BURP* that wrethced Aelfric."
		dialogue_timer.start()
	
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 28:
		Hud.baltrude_dialogue.text = " ... I have made so many mistakes ... Oh my Adeline ... I can't bear to wander these halls anymore... please..."
		dialogue_timer.start()
	
	if GameState.inRangeBaltrude and Input.is_action_just_pressed("Talk") and GameState.StoryProgress == 29:
		Hud.baltrude_dialogue.text = "Alefric ... you ... please little Peanut, if you find that man ... kill him."
	
	#Visibility Check
	#if !GameState.inRangeBaltrude && !GameState.inRangeKnut:
		#Hud.knut_dialogue.visible = false
		#Hud.baltrude_dialogue.visible = false
		#Hud.panel.visible = false
		#Hud.q_to_talk.visible = false
