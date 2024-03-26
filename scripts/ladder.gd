extends Area2D

var body_ready
var body_plr: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("jump"):
		if body_ready:
			body_plr.velocity.y = -100
			body_plr.move_and_slide()




func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		body_ready = true # Replace with function body.
		body_plr = body


func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		body_ready = false # Replace with function body.
