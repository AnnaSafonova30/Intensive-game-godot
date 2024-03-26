extends TextureButton
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	if config.get_value("levels","jungle") == true:
		disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://scenes_for_scenes/comics/comics_to_jungle.tscn")
