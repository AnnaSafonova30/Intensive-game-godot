extends Label
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str($"../../../".crystalValue)
