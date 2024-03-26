extends Area2D
var canTouch = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "CharacterBody2D" and canTouch:
		canTouch = false
		$AudioStreamPlayer2D.play()
		for i in range(10):
			$"../FunText".modulate.a += 0.1
			$"../TileMapFun".modulate.a -= 0.1
			await get_tree().create_timer(0.1).timeout

