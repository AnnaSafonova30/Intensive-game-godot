extends CharacterBody2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

signal healthChanged
signal killed
@export var crystalValue = 0
@export var checkpointCold = false
@export var checkpointLast = false
@onready var gos = $CanvasLayer/GameOverScreen
@onready var heroSkin = config.get_value('saves', 'skin')
@onready var effects = $Effects
@onready var hurtCD = $HurtCD

@onready var diescreen = $CanvasLayer/GameOverScreen

@export var knockbackPower: int = 500

@export var maxHealth = 5
var currentHealth: int = maxHealth

#var canDmg = true

@export var takenHammer = false
var knockbackDirection
var can_shoot = true
const SPEED = 350.0
const JUMP_VELOCITY = -550.0
var lightOff = false
@onready var cooldown = $Cooldown
@onready var anim_plr = get_node("AnimationPlayer")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	crystalValue = config.get_value("saves",'crystal')
	effects.play("RESET")
	#killed.connect(await _on_character_killed)
	


#11215


#Sounds
@onready var sfxDeath = get_node('Death')
@onready var sfxFootstep = get_node('Footstep')
@onready var sfxJump = get_node('Jump')
@onready var sfxLaser = get_node('Laser')



@onready var bullet = preload("res://scenes_for_scenes/bullet.tscn")
	

#func removeWall(col):
	#col.get_node('Hammer').visible = false
	

func _physics_process(delta):
	#sfxFootstep.connect("finished", Callable(self,"_on_loop_sound").bind(sfxFootstep))
	
	# Add the gravity.
	if not is_on_floor():
		if get_tree().current_scene.name == 'Cloudlvl':
			velocity.y += gravity * delta-5
		elif get_tree().current_scene.name == 'last_lvl' and checkpointLast:
			velocity.y += gravity * delta-8
		else:
			velocity.y += gravity * delta
		
		
	#FOURTH LVL
	if get_node_or_null('PointLight2D'):
		if lightOff == false:
			if get_tree().current_scene.name == 'FourthLevel':
				if position.x > 0 and $PointLight2D.energy > 0:
					lightOff = true
		elif lightOff == true and $PointLight2D.energy > 0:
			#$Camera2D/TouchScreenButton.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton5.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton2.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton3.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton4.modulate = Color('f9002f')
			$PointLight2D.energy -= 0.01
	#OTHER
	# Get the input direction and handle the movement/deceleration..;
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_a", "move_d")
	#var tween = get_tree().create_tween()
	if direction == -1:
		#$AnimatedSprite2D.scale = Vector2(1,1)
		$AnimatedSprite2D.flip_h = true
		if get_node_or_null('PointLight2D'):
			$PointLight2D.scale.x = -5.321
			$PointLight2D.offset.x = 50
		$CollisionShape2D.position.x = 70
		$hurtBox/CollisionShape2D2.position.x = 70
		#tween.tween_property($Camera2D, "offset",-200,1)
		#$Camera2D.offset.x = -100
	elif direction == 1:
		#$AnimatedSprite2D.scale = Vector2(-1,1)
		$AnimatedSprite2D.flip_h = false
		if get_node_or_null('PointLight2D'):
			$PointLight2D.scale.x = 5.321
			$PointLight2D.offset.x = -1
		$CollisionShape2D.position.x = 37
		$hurtBox/CollisionShape2D2.position.x = 37
		#tween.tween_property($Camera2D, "offset",200,1)
		#$Camera2D.offset.x = 100
		
	
	if direction:
		if not is_on_floor():
			sfxFootstep.stop()
		velocity.x = direction * SPEED
		if is_on_floor():
			if sfxFootstep.playing == false:
				sfxFootstep.play()
			if heroSkin == "default":
				anim_plr.play("run")
			else:
				anim_plr.play("move-%s"%heroSkin)
	else:
		sfxFootstep.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			if heroSkin == "default":
				anim_plr.play("idle")
			else:
				anim_plr.play("idle-%s"%heroSkin)

	if Input.is_action_just_pressed("fire"):
		if can_shoot == true:
			sfxLaser.play()
			var bullet_instance = bullet.instantiate()
			#if get_tree().current_scene.name == 'SecondLvl':
				#get_node('/root/SecondLvl').add_child(bullet_instance)
			#else:
				#get_tree().get_root().add_child(bullet_instance)
			get_tree().current_scene.add_child(bullet_instance)
			can_shoot = false
			bullet_instance.position = position
			#$Camera2D.position = bullet.position
			bullet_instance.position.y += 60
			
			#print('plr', position)
			#print('bullet', bullet.position)
			if $AnimatedSprite2D.flip_h == false:
				bullet_instance.speed = 50
				bullet_instance.position.x += 10
			else:
				bullet_instance.speed = -50
				bullet_instance.position.x += -10
			cooldown.start(1)

	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			sfxJump.play()
			if heroSkin == "default":
				anim_plr.play("jump")
			else:
				anim_plr.play("jump-%s"%heroSkin)
	if position.y >= 1100:
		#currentHealth = maxHealth
		#healthChanged.emit(currentHealth)
		#sfxDeath.play()
		#await get_tree().create_timer(1.5).timeout
		#gos.visible = true
		#Engine.time_scale = 0
		if get_tree().current_scene.name == 'FirstLevel':
			position.y = -155
			position.x = 275
		elif get_tree().current_scene.name == 'SecondLvl':
			if checkpointCold == false:
				position.y = 170
				position.x = 276
			else:
				if get_parent().get_node_or_null("Boss"):
					$"../Boss".hp = 5
					$"../Boss".position.x = 11670
					$"../Boss".position.y = -85
				position.y = -475
				position.x = 11459
		elif get_tree().current_scene.name == 'ThirdLvl':
			position.y = 1000
			position.x = 276
		elif get_tree().current_scene.name == 'FourthLevel':
			position.y = 667
			position.x = -4436.04
		elif get_tree().current_scene.name == 'Cloudlvl':
			position.y = 966
			position.x = 290
		elif get_tree().current_scene.name == 'last_lvl':
			if checkpointLast == false:
				position.x = -157.036
				position.y = 153
			else:
				if get_parent().get_node_or_null("Pluton"):
					$"../Pluton".hp = 10
					$"../Pluton".position.x = 7209
					$"../Pluton".position.y = 689
				position.x = 6217
				position.y = 420
	
	
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(i)
			
			#print(collision.get_collider())
			
			if collision.get_collider() != null:
				if collision.get_collider().is_in_group("wall_break_hammer"):
					if takenHammer == true:
						takenHammer = false
						$"../WallBreak/Hammer".visible = true
						get_node("BreakHammer").start(1)
						await get_node("BreakHammer").timeout
						var tween = get_tree().create_tween()
						tween.tween_property($"../WallBreak/Hammer", "rotation", 1, 0.5)
						tween.tween_callback($"../WallBreak".queue_free)
				#if collision.get_collider().is_in_group("enemy"):
				##hurtByEnemy(collision)
					#if get_tree().current_scene.name == 'FirstLevel':
						#position.y = -155
						#position.x = 275
					#elif get_tree().current_scene.name == 'SecondLvl':
						#position.y = 170
						#position.x = 276
					#elif get_tree().current_scene.name == 'ThirdLvl':
						#position.y = 1000
						#position.x = 276
					#elif get_tree().current_scene.name == 'FourthLevel':
						#position.y = 667
						#position.x = -4436.04
					#elif get_tree().current_scene.name == 'Cloudlvl':
						#position.y = 966
						#position.x = 290
			#elif collision.get_collider().is_in_group("interact_break"):
				#$"../Ishere/imag".texture = load('res://resources/interactive/hammer/taken.png')
	

	
	
	
	move_and_slide()


	


	

func _on_loop_sound(sound):
	sound.stream_paused = false

func _on_cooldown_timeout():
	can_shoot = true


func _on_hurt_box_area_entered(area):
	if area.name == "hitBox" and area.monitoring == true:
		#canDmg = false

		currentHealth -= 1
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				position.y = -155
				position.x = 275
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				position.y = 1000
				position.x = 276
			elif get_tree().current_scene.name == 'FourthLevel':
				position.y = 667
				position.x = -4436.04
			elif get_tree().current_scene.name == 'Cloudlvl':
				position.y = 966
				position.x = 290
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)
	elif area.name == "Mine" and area.monitoring == true:
		#canDmg = false
		currentHealth -= 2
		if currentHealth < 0:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			if get_tree().current_scene.name == 'FirstLevel':
				position.y = -155
				position.x = 275
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				position.y = 1000
				position.x = 276
			elif get_tree().current_scene.name == 'FourthLevel':
				position.y = 667
				position.x = -4436.04
			elif get_tree().current_scene.name == 'Cloudlvl':
				position.y = 966
				position.x = 290
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			sfxDeath.play()
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#area.get_parent().queue_free()
	elif area.name == "bossHit" and area.monitoring == true:
		#canDmg = false
		currentHealth -= 2
		if currentHealth < 0:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			if get_tree().current_scene.name == 'FirstLevel':
				position.y = -155
				position.x = 275
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				position.y = 1000
				position.x = 276
			elif get_tree().current_scene.name == 'FourthLevel':
				position.y = 667
				position.x = -4436.04
			elif get_tree().current_scene.name == 'Cloudlvl':
				position.y = 966
				position.x = 290
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			sfxDeath.play()
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#area.get_parent().queue_free()
	elif area.name == 'bossEnter' and area.monitoring == true:
		checkpointCold = true
	if area.name == "bulletEnemy" and area.monitoring == true:
		#canDmg = false

		currentHealth -= 1
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				position.y = -155
				position.x = 275
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				position.y = 1000
				position.x = 276
			elif get_tree().current_scene.name == 'FourthLevel':
				position.y = 667
				position.x = -4436.04
			elif get_tree().current_scene.name == 'Cloudlvl':
				position.y = 966
				position.x = 290
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)
#func _on_damage_time_timeout():
	#canDmg = true

func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func die():
	killed.emit()
	queue_free()


#func _on_character_killed():
	#await get_tree().create_timer(1.5).timeout
	#gos.visible = true
#func _on_break_hammer_timeout(collision):
	
