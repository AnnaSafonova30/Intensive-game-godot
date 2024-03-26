extends Area2D
@export var speed: float
@export var enemyBullet = false
@onready var timer = $Dissapear
@onready var player = $"../CharacterBody2D"
var motion = Vector2(0,0)
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed
	#look_at(player.position + Vector2(0,70))
	#motion = position.direction_to(player.position + Vector2(0,70)) * speed
	#motion = move_and_collide(motion)

#func _on_body_entered(body):
	#if body.name == 'Pluton':
		#pass
	#elif body.name == 'CharacterBody2D':
		#timer.start(0.1)
	#else:
		#queue_free()





func _on_dissapear_timeout():
	queue_free()



func _on_body_entered(body):
	if body.name == 'bulletEnemy' or body.name == "Pluton" or body.name.contains("RigidBody2D"):
		pass
	elif body.name == 'CharacterBody2D':
		timer.start(0.1)
	else:
		queue_free()
