extends Node2D
@export var imageName = 'fire'

# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Platform/Sprite2D.texture = load("res://resources/interactive/fixedMoveplatform/%s.png" % imageName)
	
	$Platform/AnimationPlayer.play("move_loop")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
