extends Node2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
@onready var animation = $AnimationPlayer
@onready var player = $"../CharacterBody2D"
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if animation.is_playing() == false:
		animation.play('pos')

		


func _on_area_2d_body_entered(body):
	if body.name == 'CharacterBody2D':
		queue_free()
		player.crystalValue += 1
		config.set_value('saves','crystal',config.get_value('saves','crystal')+1)
		config.save('user://config.cfg')
