extends Node


#Player states variables
var inRangeBaltrude := false

#var SaveMyGame = false
var LoadMyGame = false
#var StartNewGame = false
#
var LoadGameFlag = false
#var newGameFlag = false

#Variables to save and load
var IceCatalyst = false
var FireCalalyst = false
var Sword = false
var TomeOne = false
var TomeTwo = false
var TomeThree = false
var TomeFour = false
var TomeFive = false
var TomeSix = false
var TomeSeven = false
var KnutsEntry = false

var itemsCollected = []


#This are the variables we wish to save and load and keep track of.
var ResIce := false
var ResFire := false
var ResBalt := false
var ResKnut := false
var ResMarble := false
var ResDarkBrick := false
var ResEndGame := false

var IceCatalystCollected := false
var FireCatalystCollected := false


var baltrudeTalking := false
var StoryProgress := 0
var SideStoryProgress := 0


var HelpingKnut := false
var TomeOneCollected := false
var TomeTwoCollected := false
var TomeThreeCollected := false
var TomeFourCollected := false
var TomeFiveCollected := false
var TomeSixCollected := false
var TomeSevenCollected := false
var SwordCollected := false

#Story progression flags. If the flag is true it has been used.
var FireCatalystCollectedFlag = false
var IceCatalystCollectedFlag = false

#This is for adding items collected to our inventory in our pause menu.
func has_item(item_name: String) -> bool:
	return item_name in itemsCollected

func reset():
	
	#Respawn determiner
	ResIce = false
	ResFire = false
	ResKnut = false
	ResBalt = false
	ResMarble = false
	ResDarkBrick = false
	ResEndGame = false
	
	#Power catalyst determiner
	IceCatalystCollected = false
	FireCatalystCollected = false
	
	#Dialogue story determiner
	StoryProgress = 0
	SideStoryProgress = 0
	
	#Collectible lore determiner
	TomeOneCollected = false
	TomeTwoCollected = false
	TomeThreeCollected = false
	TomeFourCollected = false
	TomeFiveCollected = false
	TomeSixCollected = false
	TomeSevenCollected = false
	
	#Attack item determiner
	SwordCollected = false


func _ready() -> void:
	if LoadMyGame:
		SaveManager.LoadGame()
	
