extends Area2D
var is_moving = false
var body_ready
var can_move = true
@onready var anim = $AnimationPlayer
@onready var timer = $"../can_move"
@onready var startTime = $"../Start"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#move_and_collide(linear_velocity)
	#if Input.is_action_just_pressed("ui_ladder"):
		#if body_ready and is_moving == false:
			#is_moving = true
			##body_plr.velocity.y = -50
			#for i in range(320):
				#await get_tree().create_timer(0.001).timeout
				#position.y -= 0.5
			#body_plr.move_and_slide()




#func _on_body_entered(body):
	#print(body)
	#if body.name == "CharacterBody2D":
		#
		#body_ready = true # Replace with function body.
		##body_plr = body
#
#
#func _on_body_exited(body):
	#if body.name == "CharacterBody2D":
		#body_ready = false # Replace with function body.

#
#func _on_body_entered(body):
	#print(body)
	#if body.name == "CharacterBody2D":
		#
		#body_ready = true # Replace with function body.
		##body_plr = body
#
#
#func _on_body_exited(body):
	#if body.name == "CharacterBody2D":
		#body_ready = false # Replace with function body.


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		if anim.is_playing() == false and can_move:
			can_move = false
			
			$TextureRect.texture = load("res://resources/elevator/asset/1.png")
			$TextureRect.z_index = 999
			$CollideElevator.set_collision_layer_value(1, true)
			$CollideElevator.set_collision_mask_value(1, true)
			if position.y == -500:
				anim.play('down_elevator')
			#for i in 500:
					#position.y += 1
					
				#is_moving = false
			else:
				anim.play("move_elevator")
				#for i in 500:
					#position.y -= 1
				#is_moving = false
			timer.start()
			

		#if is_moving == false:
			#is_moving == true
			#startTime.start()
			
		#body_plr = body



#func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print("Body", body)
	#if body.name == "CharacterBody2D":
		#print(anim)
		#if anim.is_playing() == false:
		##if is_moving == false:
			##is_moving == true
			#print(position.y)
			#if position.y == -500:
				#anim.play('down_elevator')
				##for i in 500:
					##position.y += 1
					#
				##is_moving = false
			#else:
				#anim.play("move_elevator")
				##for i in 500:
					##position.y -= 1
				##is_moving = false
		##body_plr = body



func _on_can_move_timeout():
	can_move = true


func _on_animation_player_animation_finished(anim_name):
	$TextureRect.texture = load("res://resources/elevator/asset/elevatorShip.png")
	$TextureRect.z_index = 0
	$CollideElevator.set_collision_layer_value(1, false)
	$CollideElevator.set_collision_mask_value(1, false)


func _on_start_timeout():
	$TextureRect.texture = load("res://resources/elevator/asset/1.png")
	$TextureRect.z_index = 999
	
	if position.y == -500:
		anim.play('down_elevator')
			#for i in 500:
					#position.y += 1
					
				#is_moving = false
	else:
		anim.play("move_elevator")
				#for i in 500:
					#position.y -= 1
				#is_moving = false
	timer.start()
