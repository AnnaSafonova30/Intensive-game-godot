extends Camera2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.get_value('options', 'smoothcamera') == false:
		position_smoothing_enabled = false
	else:
		position_smoothing_enabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
