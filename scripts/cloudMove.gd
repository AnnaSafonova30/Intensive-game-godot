extends Area2D
var body_plr: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += 0.1
	
	




func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		body_plr = body
		
	
