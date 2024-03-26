extends Control
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
var skinName = 'default'
var amountCrystals = config.get_value('saves','crystal')
var listBoughtSkins: Array = []
var fullscreen

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in config.get_section_keys("skins"):
		if config.get_value('skins',i):
			listBoughtSkins.append(i)
	#DiscordSDK.app_id = 1221524982148894890 # Application ID
	#DiscordSDK.details = "WORLD IT GameJam: Godot Engine"
	#DiscordSDK.large_image = "pluton" # Image key from "Art Assets"
	#DiscordSDK.large_image_text = "Retribution Of Pluto: The Galactic Rogue"
	#DiscordSDK.small_image = 'pluton' # Image key from "Art Assets"
	#DiscordSDK.small_image_text = "In The Menu"
#
	#DiscordSDK.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
  ## DiscordSDK.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"
	#DiscordSDK.refresh() # Always refresh after changing the values!
	
	
	if configFile != OK:
		print("Create Config")
		
		config.set_value("options", "vsync", true)
		config.set_value("options", "fullscreen", true)
		config.set_value("options", "smoothcamera", false)
		config.set_value("options", "30fps", false)
		config.set_value("options", "strechscreen", false)
		config.set_value("options", "music", true)
		config.set_value("options", "light", false)
		
		config.set_value("levels", "ice", false)
		config.set_value("levels", "acid", false)
		config.set_value("levels", "jungle", false)
		config.set_value("levels", "wind", false)
		config.set_value("levels", "last", false)
		
		config.set_value("skins", "cold", false)
		config.set_value("skins", "acid", false)
		config.set_value("skins", "jungle", false)
		config.set_value("skins", "wind", false)
		config.set_value("skins", "fire", false)
		
		config.set_value('saves','crystal', 0)
		config.set_value("saves","skin","default")
		
		config.save("user://config.cfg")
	
	fullscreen = config.get_value('options', 'fullscreen')
	
	if fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		
	if config.get_value('options', 'vsync') == false:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	
	if config.get_value('options', '30fps') == false:
		Engine.max_fps = 0
	else:
		Engine.max_fps = 30
	
	if config.get_value('options', 'light') == false:
		$FPSCounter.visible = false
	else:
		$FPSCounter.visible = true
		
	if config.get_value("options", "strechscreen") == false:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	else:
		get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_IGNORE
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#DiscordSDK.run_callbacks()
	if Input.is_action_just_pressed("fullscreen"):
		if fullscreen == false:
			fullscreen = true
			config.set_value("options", "fullscreen", true)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			fullscreen = false
			config.set_value("options", "fullscreen", false)
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")

func buy_skin(skin):
	
	print("Name", skin.item_to_buy)
	print("Price", skin.price)
	if amountCrystals >= skin.price:
		amountCrystals -= skin.price
		listBoughtSkins.append(skin.item_to_buy)
		#print(amountCrystals)
		#config.set_value("saves","crystal",amountCrystals)
		$Value/Label.text = str(amountCrystals) #-int($price.text)
		#config.set_value("skins",item_to_buy,true)
		skin.visible = false
		skin.get_parent().get_node(skin.item_to_buy).visible = true
		#config.save('user://config.cfg')

func _on_buy_pressed(path):
	var skin = get_node(path)
	#print(skin.item_to_buy)
	buy_skin(skin)
