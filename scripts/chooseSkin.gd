extends BoxContainer
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
@export var skin = "jungle"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_rect_pressed():
	#config.set_value('saves', 'skin', get_node(skin).get_node("Label2").text.to_lower())
	get_parent().get_parent().get_parent().skinName = get_node(skin).get_node("Label2").text.to_lower()
	$"../../Skin".texture = load("res://resources/player/hero/%s/Idle/1.png"%get_node(skin).get_node("Label2").text.to_lower())
	#config.save('user://config.cfg')
	
