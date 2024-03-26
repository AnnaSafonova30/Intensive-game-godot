extends RigidBody2D #Наследуем RigidBody2D
#Експортируем свойства
var dead = false
var can_move = true
var start_x #Свойства start_x (начало пути)
@onready var player = null
var go_to_plr = false
@onready var sfxLaser = get_node('Laser')
var can_shoot = true
@onready var shootTimer = $TimerShoot
@onready var bullet = preload("res://scenes_for_scenes/bulletForwardEnemy.tscn")
#var can_jump = true
@export var cant_search_player = false
#@export var timePerJump: int = 0
@export var hp: int = 5
var start_y: int = 0 #Свойства start_y (НЕИСПОЛЬЗОВАТЬ)
@export var end_x: int = 0 #Свойства end_x (конец пути)
var SPEED: float = 3 #Свойства SPEED (скорость бота
#Направление
#var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
var direction: int = 0
#var on_ground := 0
#@onready var timerJ = $TimerJump
@onready var timerM = $TimerMove
# Функция, которая запускается при запуске сцены
func _ready():
	start_x = position.x #Ставим начальный путь
	if start_y != 0: #Если start_y не равняется нулю, то
		position.y = start_y #
# Функция для процесса работы бота
func _physics_process(delta):
	#Смены направления
	# Если позиция x больше или равна конца пути, то
	if go_to_plr and cant_search_player == false:
		can_move = true
		SPEED = 4
		if position.x >= player.position.x:
			direction = -1 #Меняем направление назад
			#$CollisionShape2D.position.x = 15
			#$RayCast2D.position.x = 15
			#$bossHit/CollisionShape2D.position.x = 15
			$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
		else: #Если позиция x меньше конца пути, то
			direction = 1 #Меняем направление назад
			#$RayCast2D.position.x = 35
			#$CollisionShape2D.position.x = 35
			#$bossHit/CollisionShape2D.position.x = 35
			$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
	else:
		SPEED = 3
		if position.x >= end_x:
			direction = -1 #Меняем направление назад
			#$CollisionShape2D.position.x = 15
			#$RayCast2D.position.x = 15
			#$RayCast2D1.position.x = 17
			#$bossHit/CollisionShape2D.position.x = 15
			#$RayCast2D2.position.x = 17
			$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
		else: #Если позиция x меньше конца пути, то
			direction = 1 #Меняем направление назад
			#$RayCast2D.position.x = 35
			#$RayCast2D1.position.x = 37
			#$RayCast2D2.position.x = 37
			#$CollisionShape2D.position.x = 35
			$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
			#$bossHit/CollisionShape2D.position.x = 35
	# Если бот дошел до конца, то возращается обратно
	if go_to_plr == false and cant_search_player == false:
		if position.x <= end_x + 10 and position.x >= end_x - 10:
			#if not ($RayCast2D.is_colliding() or $RayCast2D1.is_colliding() or $RayCast2D2.is_colliding()):
				#can_move = false
			var temp = start_x # Меняем темп на начало пути
			start_x = end_x # Начало пути стало концом пути
			end_x = temp # Конец пути стало равняться началом пути
			timerM.start(5)
	#print($RayCast2D.is_colliding())
	
	#Стрельба
	if can_shoot and go_to_plr and dead == false and cant_search_player == false:
		sfxLaser.play()
		var bullet_instance = bullet.instantiate()
			#if get_tree().current_scene.name == 'SecondLvl':
				#get_node('/root/SecondLvl').add_child(bullet_instance)
			#else:
				#get_tree().get_root().add_child(bullet_instance)
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.position = position
			#$Camera2D.position = bullet.position
		bullet_instance.position.y += 65
		can_shoot = false
			#print('plr', position)
			#print('bullet', bullet.position)
		if $AnimatedSprite2D.flip_h == true:
			bullet_instance.speed = -10
			#bullet_instance.position.x += -56
		else:
			bullet_instance.speed = 10
			#bullet_instance.position.x += 309
		shootTimer.start(1)
		
	#if ($RayCast2D.is_colliding() or $RayCast2D1.is_colliding() or $RayCast2D2.is_colliding()) and can_jump and linear_velocity.length() < 5 : #linear_velocity.length() < 1 
		#can_jump = false
		#set_axis_velocity(Vector2(0, -5))
		#timerJ.start(timePerJump)
		#SPEED = 1.0
	# Если передвигается
	if direction:
		linear_velocity.x = direction * SPEED #Двигаем бота
	#print(linear_velocity.length())
	# Без этого, бот был бы пьян.
	if not dead:
		move_and_collide(linear_velocity)
	if position.y >= 2000:
		queue_free()
#func _on_body_exited(body):
	#on_ground -= 1
#func _on_timer_timeout():
	#can_jump = true
func _on_find_plr_body_entered(body):
	if body.name == 'CharacterBody2D' and cant_search_player == false:
		player = body
		go_to_plr = true
func _on_find_plr_body_exited(body):
	if body.name == 'CharacterBody2D' and cant_search_player == false:
		go_to_plr = false
func _on_timer_move_timeout():
	can_move = true


func _on_timer_shoot_timeout():
	can_shoot = true
