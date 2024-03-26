extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var right = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(rotation)
	if rotation >= 0.1:
		right = false
	elif rotation <= -0.1:
		right = true
	
	if right == true:
		rotation += 0.001
		position.x -= 0.1
	else:
		rotation -= 0.001
		position.x += 0.1
