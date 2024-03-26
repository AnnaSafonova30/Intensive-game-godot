extends BoxContainer
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
var on = load('res://resources/buttons/galochka_pressed.png')
var off = load('res://resources/buttons/galochka_ne_pressed.png')
# Called when the node enters the scene tree for the first time.
func _ready():
	if config.get_value('options', 'fullscreen') == true:
		$TextureButton.texture_normal = on
		$TextureButton.texture_pressed = on
		$TextureButton.texture_hover = on
	else:
		$TextureButton.texture_normal = off
		$TextureButton.texture_pressed = off
		$TextureButton.texture_hover = off

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


		
		
func _on_texture_button_pressed():
	if config.get_value('options', 'fullscreen') == false:
		$TextureButton.texture_normal = on
		$TextureButton.texture_pressed = on
		$TextureButton.texture_hover = on
		
		config.set_value('options', 'fullscreen',true)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		$TextureButton.texture_normal = off
		$TextureButton.texture_pressed = off
		$TextureButton.texture_hover = off

		
		config.set_value('options', 'fullscreen',false)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	config.save('user://config.cfg')
