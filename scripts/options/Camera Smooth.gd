extends BoxContainer
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
var on = load('res://resources/buttons/galochka_pressed.png')
var off = load('res://resources/buttons/galochka_ne_pressed.png')
# Called when the node enters the scene tree for the first time.
func _ready():
	if config.get_value('options', 'music') == true:
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
	if config.get_value('options', 'music') == false:
		$TextureButton.texture_normal = on
		$TextureButton.texture_pressed = on
		$TextureButton.texture_hover = on
		$"../../../Music".play()
		config.set_value('options', 'music',true)
	else:
		$TextureButton.texture_normal = off
		$TextureButton.texture_pressed = off
		$TextureButton.texture_hover = off

		$"../../../Music".stop()
		config.set_value('options', 'music',false)
	config.save('user://config.cfg')
