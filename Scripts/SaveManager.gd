extends Node


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		SaveGame()


func SaveGame():
	var data = {
		"ResIce": GameState.ResIce,
		"ResFire": GameState.ResFire,
		"ResBalt": GameState.ResBalt,
		"ResKnut": GameState.ResKnut,
		"ResMarble": GameState.ResMarble,
		"ResDarkBrick": GameState.ResDarkBrick,
		"ResEndGame": GameState.ResEndGame,
		"IceCatalystCollected": GameState.IceCatalystCollected,
		"FireCatalystCollected": GameState.FireCatalystCollected,
		"StoryProgress": GameState.StoryProgress,
		"SideStoryProgress": GameState.SideStoryProgress,
		"HelpingKnut": GameState.HelpingKnut,
		"SwordCollected": GameState.SwordCollected,
		"TomeOneCollected": GameState.TomeOneCollected,
		"TomeTwoCollected": GameState.TomeTwoCollected,
		"TomeThreeCollected": GameState.TomeThreeCollected,
		"TomeFourCollected": GameState.TomeFourCollected,
		"TomeFiveCollected": GameState.TomeFiveCollected,
		"TomeSixCollected": GameState.TomeSixCollected,
		"TomeSevenCollected": GameState.TomeSevenCollected,
		"LoadMyGame": GameState.LoadMyGame,
		"LoadGameFlag": GameState.LoadGameFlag,
		
	}
	var file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	file.store_var(data)

func LoadGame():
	if FileAccess.file_exists("user://savegame.save"):
		var file = FileAccess.open("user://savegame.save", FileAccess.READ)
		var data = file.get_var()
		GameState.ResIce = data.get("ResIce",false)
		GameState.ResFire = data.get("ResFire",false)
		GameState.ResBalt = data.get("ResBalt",false)
		GameState.ResKnut = data.get("ResKnut",false)
		GameState.ResMarble = data.get("ResMarble",false)
		GameState.ResDarkBrick = data.get("ResDarkBrick",false)
		GameState.ResEndGame = data.get("ResEndGame",false)
		GameState.IceCatalystCollected = data.get("IceCatalystCollected",false)
		GameState.FireCatalystCollected = data.get("FireCatalystCollected",false)
		GameState.StoryProgress = data.get("StoryProgress",0)
		GameState.SideStoryProgress = data.get("SideStoryCatalyst",0)
		GameState.HelpingKnut = data.get("HelpingKnut",false)
		GameState.SwordCollected = data.get("SwordCollected",false)
		GameState.TomeOneCollected = data.get("TomeOneCollected",false)
		GameState.TomeTwoCollected = data.get("TomeTwoCollected",false)
		GameState.TomeThreeCollected = data.get("TomeThreeCollected",false)
		GameState.TomeFourCollected = data.get("TomeFourCollected",false)
		GameState.TomeFiveCollected = data.get("TomeFiveCollected",false)
		GameState.TomeSixCollected = data.get("TomeSixCollected",false)
		GameState.TomeSevenCollected = data.get("TomeSevenCollected",false)
		GameState.LoadMyGame = data.get("LoadMyGame",false)
		GameState.LoadGameFlag = data.get("LoadGameFlag",false)
		

func _on_quit():
	SaveGame()
