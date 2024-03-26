extends TextureButton
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if get_tree().current_scene.name == 'Skins':
		config.set_value('saves', 'skin', get_parent().skinName) #get_node(skin).get_node("Label2").text.to_lower()
		for i in get_parent().listBoughtSkins:
		#
		#valueCrystals.text = str(amountCrystals) #-int($price.text)
			config.set_value("skins",i,true)
		config.set_value("saves","crystal",get_parent().amountCrystals)
		config.save('user://config.cfg')
	get_tree().change_scene_to_file("res://main_scenes/main_menu.tscn")
