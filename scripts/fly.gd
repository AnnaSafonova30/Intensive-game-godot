extends AnimatedSprite2D
var canFly = false

  

func fly():
	if canFly == true:
		position.x += 10
	else:
		await get_tree().create_timer(30).timeout
		canFly = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fly()
