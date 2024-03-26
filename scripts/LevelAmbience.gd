extends AudioStreamPlayer2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	if configFile != OK:
		config.set_value("options", "vsync", true)
		config.set_value("options", "fullscreen", true)
		config.set_value("options", "smoothcamera", true)
		config.set_value("options", "30fps", false)
		config.set_value("options", "strechscreen", false)
		config.set_value("options", "music", true)
		config.save("user://config.cfg")
	else:
		if config.get_value("options","music") == true:
			play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
