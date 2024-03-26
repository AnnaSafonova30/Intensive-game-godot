extends RigidBody2D #Наследуем RigidBody2D
#Експортируем свойства
var dead = false
var can_move = true
var start_x #Свойства start_x (начало пути)
var player = null
var go_to_plr = false




@export var cant_search_player = false
var start_y: int = 0 #Свойства start_y (НЕИСПОЛЬЗОВАТЬ)
@export var end_x: int = 0 #Свойства end_x (конец пути)
var SPEED: float = 3 #Свойства SPEED (скорость бота
#Направление
#var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
var direction: int = 0
#var on_ground := 0
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
	if go_to_plr:
		can_move = true
		SPEED = 4
		linear_velocity = Vector2.ZERO
		linear_velocity = position.direction_to(player.position) * SPEED
		#position += (player.position - position)/50
		#look_at(player.position)
		if position.x >= player.position.x:
			direction = -1 #Меняем направление назад
			$CollisionShape2D.position.x = 15
			$hitBox/CollisionShape2D.position.x = 15
			$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
		else: #Если позиция x меньше конца пути, то
			direction = 1 #Меняем направление назад
			$CollisionShape2D.position.x = 35
			
			$hitBox/CollisionShape2D.position.x = 35
			$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
	else:
		SPEED = 3
		if position.x >= end_x:
			direction = -1 #Меняем направление назад
			$CollisionShape2D.position.x = 15
			$hitBox/CollisionShape2D.position.x = 15
			$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
		else: #Если позиция x меньше конца пути, то
			direction = 1 #Меняем направление назад
			$CollisionShape2D.position.x = 35
			$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
			$hitBox/CollisionShape2D.position.x = 35
	# Если бот дошел до конца, то возращается обратно
	if go_to_plr == false:
		if position.x <= end_x + 10 and position.x >= end_x - 10:
			var temp = start_x # Меняем темп на начало пути
			start_x = end_x # Начало пути стало концом пути
			end_x = temp # Конец пути стало равняться началом пути
			timerM.start(5)
	#print($RayCast2D.is_colliding())
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
func _on_find_plr_body_entered(body):
	if body.name == 'CharacterBody2D' and cant_search_player == false:
		player = body
		go_to_plr = true
func _on_find_plr_body_exited(body):
	if body.name == 'CharacterBody2D' and cant_search_player == false:
		go_to_plr = false
func _on_timer_move_timeout():
	can_move = true
