extends Control

@onready var pause_menu: Control = $"."
@onready var pausetext: Label = $Pausetext
@onready var pause_buttons: VBoxContainer = $pauseButtons
@onready var tome_panel: Panel = $TomePanel
@onready var tome_knowledge: Label = $TomePanel/TomeScroll/TomeKnowledge
@onready var item_panel: Panel = $ItemPanel
@onready var tomes: OptionButton = $pauseButtons/Tomes
@onready var items: Button = $pauseButtons/Items



@onready var ice_icon_button: TextureButton = $ItemPanel/ItemIconContainer/IceIconButton
@onready var fire_icon_button: TextureButton = $ItemPanel/ItemIconContainer/FireIconButton
@onready var earth_icon_button: TextureButton = $ItemPanel/ItemIconContainer/EarthIconButton
@onready var sword_icon_button: TextureButton = $ItemPanel/ItemIconContainer/SwordIconButton


@onready var ice_info_panel: Panel = $ItemPanel/IceInfoPanel
@onready var fire_info_panel: Panel = $ItemPanel/FireInfoPanel
@onready var earth_info_panel: Panel = $ItemPanel/EarthInfoPanel
@onready var sword_info_panel: Panel = $ItemPanel/SwordInfoPanel


@onready var ice_info_label: Label = $ItemPanel/IceInfoPanel/IceInfoLabel
@onready var fire_info_label: Label = $ItemPanel/FireInfoPanel/FireInfoLabel
@onready var earth_info_label: Label = $ItemPanel/EarthInfoPanel/EarthInfoLabel
@onready var sword_info_label: Label = $ItemPanel/SwordInfoPanel/SwordInfoLabel


var entryOneFlag = false
var entryTwoFlag = false
var entryThreeFlag = false
var entryFourFlag = false
var entryFiveFlag = false
var entrySixeFlag = false
var entrySevenFlag = false



func _ready() -> void:
	unpause()
	tome_panel.visible = false
	item_panel.visible = false
	tomes.disabled = true
	items.disabled = true
	
	ice_icon_button.disabled = true
	ice_icon_button.visible = false
	ice_info_panel.visible = false
	
	fire_icon_button.disabled = true
	fire_icon_button.visible = false
	fire_info_panel.visible = false
	
	earth_icon_button.disabled = true
	earth_icon_button.visible = false
	earth_info_panel.visible = false
	
	sword_icon_button.disabled = true
	sword_icon_button.visible = false
	sword_info_panel.visible = false
	
	


func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("pause"):
		pause()


func unpause():
	pause_menu.visible = false
	pausetext.visible = false
	pause_buttons.visible = false
	get_tree().paused = false



func pause():
	get_tree().paused = true
	pause_menu.visible = true
	pausetext.visible = true
	pause_buttons.visible = true
	
	
	if GameState.has_item("iceCatalyst"):
			items.disabled = false
			ice_icon_button.disabled = false
			ice_icon_button.visible = true
			
	if GameState.has_item("fireCatalyst"):
		fire_icon_button.disabled = false
		fire_icon_button.visible = true
		
	if GameState.has_item("sword"):
		sword_icon_button.disabled = false
		sword_icon_button.visible = true
	
	if GameState.has_item("entryOne"):
		tomes.disabled = false
		if entryOneFlag == false:
			tomes.add_item("Entry One")
			entryOneFlag = true
	
	if GameState.has_item("entryTwo"):
		tomes.disabled = false
		if entryTwoFlag == false:
			tomes.add_item("Entry Two")
			entryTwoFlag = true
	
	if GameState.has_item("entryThree"):
		tomes.disabled = false
		if entryThreeFlag == false:
			tomes.add_item("Entry Three")
			entryThreeFlag = true
	
	if GameState.has_item("entryFour"):
		tomes.disabled = false
		if entryFourFlag == false:
			tomes.add_item("Entry Four")
			entryFourFlag = true
	
	if GameState.has_item("entryFive"):
		tomes.disabled = false
		if entryFiveFlag == false:
			tomes.add_item("Entry Five")
			entryFiveFlag = true
	
	if GameState.has_item("entrySix"):
		tomes.disabled = false
		if entrySixeFlag == false:
			tomes.add_item("Entry Six")
			entrySixeFlag = true
		
	if GameState.has_item("entrySeven"):
		tomes.disabled = false
		if entrySevenFlag == false:
			tomes.add_item("Entry Seven")
			entrySevenFlag = true


func _on_resume_pressed() -> void:
	SaveManager.SaveGame()
	unpause()
	tome_panel.visible = false
	item_panel.visible = false



func _on_quit_pressed() -> void:
	SaveManager.SaveGame()
	GameState.LoadGameFlag = true
	GameState.LoadMyGame = true
	unpause()
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
	



func _on_tomes_item_selected(index: int) -> void:
	
	if index > 0:
		tome_panel.visible = true
	else:
		tome_panel.visible = false
	
	
	
	
	
	if GameState.has_item("entryOne"):
		if tomes.text == "Entry One":
			tome_knowledge.text =  "July 17th, 1055  - 
			What a glorious castle Adeline and I have found ourselves in. Legends speak of Orm the Ruler, and the Golden Age. We have set out on a quest to find an artifact said to have belonged to Aed the Disciple of Light and Dark. These halls are said to be endless. My dear Adeline is here with me to guide me with her glorious wisdom. She will give birth to our child in the coming months, We must find our prize quick and return home.
			- Baltrude"
	
	if GameState.has_item("entryTwo"):
			if tomes.text == "Entry Two":
				tome_knowledge.text = "July 18th, 1055 - I have underestimated the rumors of this castle. We should have never come here. No magic is worth the sacrifices we have made. We are close to the exit, but the riddles written by these walls are cruel and unusual. 
			- Baltrude"
	#
	if GameState.has_item("entryThree"):
		if tomes.text == "Entry Three":
			tome_knowledge.text = "August 3rd, 1055 - Months have now passed. Adeline has given birth to a glorious son ... What a terrible place to grow up. I wish to show him the world. I fear he will become quite familiar with the marking on the walls. The birth was too much for Adeline. She has grown quite sick. I fear for her ... I cannot do this without her. I must find a way out.
			- Baltrude"
		#
	if GameState.has_item("entryFour"):
		if tomes.text == "Entry Four":
			tome_knowledge.text = "Feburary 20th, 1056 - 
			Oh Adeleine ... The sickness has spread through her in such a diabolic way. She has begun to forget me ... I do not even recognize her anymore. I fear that soon I must resort to a dark magic. I must protect her mind, but I fear it is too far gone. Oh Aelfric, our poor, beautiful son. He is too young to understand. I will teach him everything. If I cannot get out, hopefully at least he can.
			- Baltrude"
	#
	if GameState.has_item("entryFive"):
		if tomes.text == "Entry Five":
			tome_knowledge.text = "September 17th, 1061 - 
			I miss my Adeline ... Aelfric's face reminds me so much of her. I cannot bear to look at him. He is now five years old. His life was too much for Adeline to support. I must not blame him for her death but it is hard. He is just a boy. I have begun biologic experimentations. I have kept her flesh alive, feeding them bits of magics. I fear I must begin testing on the same creature we have resorted to eating. There are creatures in this castle that no god has made.
			-Baltrude"
	#
	if GameState.has_item("entrySix"):
		if tomes.text == "Entry Six":
			tome_knowledge.text = "June 27th, 1075 - 
			This boy keep telling about his father, Baltrude. He tells me today marks his 19th birthday. Disgusting creature, he is. I don't even remeber my age. He tells me, that my mind has begun to go and that he wants help me. When I look at this young man I am overswept with hatred. These feelings come from deep inside and I do not understand them. I do not care for his ramblings. My beautiful Adeline teeters on the brim of life and death. I am so close to bringing her back. She is all I want. I want to show her my home. I want to show her this beautiful castle I have built for her. The potion is so close, I have been brewing it for years now.
			- ... "
	#
	if GameState.has_item("entrySeven"):
		if tomes.text == "Entry Seven":
			tome_knowledge.text = "September 22nd, 1075 - 
			Gone ... it is all gone. That boy ruined it all. Adeline was basically back and Aelfric ruined it. In an act of pure destruction he destroyed my potion. He shall pay for his actions."



func _on_ice_icon_button_toggled(toggled_on: bool) -> void:
	
	if toggled_on:
		ice_info_label.text = "Legends speak of a time before war. A time of peace. When a need for catlysts did not exist."
	elif !toggled_on:
		ice_info_label.text = "The Ice Catalyst - This item allows you to WALL JUMP"



func _on_fire_icon_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		fire_info_label.text = "The counterpart to the Ice Catalyst, this artifact of destruction turned the tide of the unending war."
	elif !toggled_on:
		fire_info_label.text = "The Fire Catalyst - This item allows you to DOUBLE JUMP"


func _on_items_pressed() -> void:
	
		if item_panel.visible == false:
			item_panel.visible = true
			if ice_icon_button.visible == true:
				ice_info_panel.visible = true
				ice_info_label.visible = true
				ice_info_label.text = "The Ice Catalyst - This item allows you to WALL JUMP"
			
			if fire_icon_button.visible == true:
				fire_info_panel.visible = true
				fire_info_label.visible = true
				fire_info_label.text = "The Fire Catalyst - This item allows you to DOUBLE JUMP"
			
			if sword_icon_button.visible == true:
				sword_info_label.visible = true
				sword_info_panel.visible = true
				sword_info_label.text = "Aelfric's Dagger - This item allows you to ATTACK - Spacebar"
	
		elif item_panel.visible == true:
			item_panel.visible = false


func _on_sword_icon_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		sword_info_label.text = "This little blade was used by Alefric to kill his mother."
	elif !toggled_on:
		sword_info_label.text = "Aelfric's Dagger - This item allows you to ATTACK - Spacebar"
