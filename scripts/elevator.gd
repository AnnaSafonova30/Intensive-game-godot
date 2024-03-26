extends Path2D

@export var loop = true
@export var speed = 2.0
@export var speed_scale = 1.0



@onready var path = $PathFollow2D
@onready var animation = $AnimationPlayer

func _on_area_entered(area):
	if area.name == "hurtBox":
		$AnimationPlayer.play("moveup")


# Called when the node enters the scene tree for the first time.
func _ready():
	if not loop:
		animation.play("moveup")
		animation.speed_scale = speed_scale
		set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	path.progress += speed
