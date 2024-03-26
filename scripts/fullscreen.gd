extends Node2D
var fullscreen = false
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
@onready var heartsContainer = $CharacterBody2D/CanvasLayer/heartsContainer
var assetDiscordArt = 'fire'
var assetDiscordText = 'Pyron'
func _ready():
	#if OS.get_name() != "Android":

	heartsContainer.setMaxHearts($CharacterBody2D.maxHealth)
	heartsContainer.updateHearts($CharacterBody2D.currentHealth)
	$CharacterBody2D.healthChanged.connect(heartsContainer.updateHearts)
	if get_tree().current_scene.name == 'FirstLevel':
		assetDiscordArt = 'fire'
		assetDiscordText = 'Pyron'
	elif get_tree().current_scene.name == 'SecondLvl':
		assetDiscordArt = 'ice'
		assetDiscordText = 'Krios'
	elif get_tree().current_scene.name == 'ThirdLvl':
		assetDiscordArt = 'acid'
		assetDiscordText = 'Axis'
	elif get_tree().current_scene.name == 'FourthLevel':
		assetDiscordArt = 'jungle'
		assetDiscordText = 'Verdis'
	elif get_tree().current_scene.name == 'Cloudlvl':
		assetDiscordArt = 'wind'
		assetDiscordText = 'Zephir'
	elif get_tree().current_scene.name == 'last_lvl':
		assetDiscordArt = 'last'
		assetDiscordText = 'Earth'
	elif get_tree().current_scene.name == 'Ship':
		assetDiscordArt = 'ship'
		assetDiscordText = 'Ship'
	#DiscordSDK.app_id = 1221524982148894890 # Application ID
	#DiscordSDK.details = "WORLD IT GameJam: Godot Engine"
	#DiscordSDK.large_image = "pluton" # Image key from "Art Assets"
	#DiscordSDK.large_image_text = "Retribution Of Pluto: The Galactic Rogue"
	#DiscordSDK.small_image = assetDiscordArt # Image key from "Art Assets"
	#DiscordSDK.small_image_text = "Passes the level : %s"%assetDiscordText
#
	#DiscordSDK.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
  ## DiscordSDK.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"
#
	#DiscordSDK.refresh() # Always refresh after changing the values!
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if OS.get_name() != 'Android':
		
	if config.get_value("options", "strechscreen") == false:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	else:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	
	if config.get_value('options', 'light') == false:
		$CharacterBody2D/Camera2D/FPSCounter.visible = false
	else:
		$CharacterBody2D/Camera2D/FPSCounter.visible = true
	
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			fullscreen = true
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			fullscreen = false
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("escape"):
		if Engine.time_scale == 0:
			Engine.time_scale = 1
			#$CharacterBody2D/Music.playing = true
			$CharacterBody2D/Camera2D/Pause.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton2.show()
			$CharacterBody2D/Camera2D/TouchScreenButton3.show()
			$CharacterBody2D/Camera2D/TouchScreenButton4.show()
			$CharacterBody2D/Camera2D/TouchScreenButton5.show()
			$CharacterBody2D/Camera2D/TouchScreenButton.show()
		else:
			Engine.time_scale = 0
			#$CharacterBody2D/Music.playing = false
			$CharacterBody2D/Camera2D/Pause.show()
			$CharacterBody2D/Camera2D/TouchScreenButton2.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton3.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton4.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton5.hide()
			$CharacterBody2D/Camera2D/TouchScreenButton.hide()
		#get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")
	#DiscordSDK.run_callbacks()
