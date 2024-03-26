extends Button
@onready var player = $"../../../../../"
#@onready var boss = $"../../../../../../Boss"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var boss = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("Boss")
	
	Engine.time_scale = 1
	$"../../../".hide()
	$"../../../../TouchScreenButton2".show()
	$"../../../../TouchScreenButton5".show()
	$"../../../../TouchScreenButton4".show()
	$"../../../../TouchScreenButton3".show()
	$"../../../../TouchScreenButton".show()

	if get_tree().current_scene.name == 'FirstLevel':
		player.position.y = -155
		player.position.x = 275
	elif get_tree().current_scene.name == 'SecondLvl':
		if player.checkpointCold == false:
			player.position.y = 170
			player.position.x = 276
		else:
			if boss:
				$"../../../../../../Boss".position.x = 11670
				$"../../../../../../Boss".position.y = -85
				print("moved boss (no)")
			player.position.y = -25
			player.position.x = 11209
	elif get_tree().current_scene.name == 'ThirdLvl':
		player.position.y = 1000
		player.position.x = 276
	elif get_tree().current_scene.name == 'FourthLevel':
		player.position.y = 667
		player.position.x = -4436.04
	elif get_tree().current_scene.name == 'Cloudlvl':
		player.position.y = 966
		player.position.x = 290
	elif get_tree().current_scene.name == 'last_lvl':
		player.position.x = -157.036
		player.position.y = 153
