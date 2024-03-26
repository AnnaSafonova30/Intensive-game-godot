extends RigidBody2D #Наследуем RigidBody2D
#Експортируем свойства
var start_x #Свойства start_x (начало пути)
@export var start_y: int = 0 #Свойства start_y (НЕИСПОЛЬЗОВАТЬ)
@export var end_x: int = 0 #Свойства end_x (конец пути)
@export var SPEED: float = 250.0 #Свойства SPEED (скорость бота
#Направление
var direction: int = 0

# Функция, которая запускается при запуске сцены
func _ready():
	#var bullet = preload("res://scenes_for_scenes/lightfire.tscn").instantiate()
	#bullet.position = end_x
	#get_tree().get_root().add_child(bullet)
	start_x = position.x #Ставим начальный путь
	if start_y != 0: #Если start_y не равняется нулю, то
		position.y = start_y #


# Функция для процесса работы бота
func _process(delta):
	
	#Смены направления
	# Если позиция x больше или равна конца пути, то
	if position.x >= end_x:
		direction = -1 #Меняем направление назад
		$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
	else: #Если позиция x меньше конца пути, то
		direction = 1 #Меняем направление назад
		$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
	# Если бот дошел до конца, то возращается обратно
	if position.x <= end_x + 10 and position.x >= end_x - 10:
		var temp = start_x # Меняем темп на начало пути
		start_x = end_x # Начало пути стало концом пути
		end_x = temp # Конец пути стало равняться началом пути
	

	# Если передвигается
	if direction:
		linear_velocity.x = direction * SPEED #Двигаем бота
	# Без этого, бот был бы пьян.
	move_and_collide(linear_velocity)
