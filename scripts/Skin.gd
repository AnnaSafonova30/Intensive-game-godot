extends TextureRect
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	texture = load("res://resources/player/hero/%s/Idle/1.png"%config.get_value('saves', 'skin'))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
