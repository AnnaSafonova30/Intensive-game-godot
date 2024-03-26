extends AudioStreamPlayer2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.get_value('options', 'music') == true:
		playing = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass # Replace with function body.
