extends Area2D
@onready var timer = $"../Remove"
@onready var minepressed = $"../AnimationPlayer"
var pressed = false

#func _on_hit_box_area_entered(area):

func _ready():
	minepressed.play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "hurtBox" and pressed == false:
		$"../AudioStreamPlayer2D".play()
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		pressed = true
		minepressed.play("boom")
		$"../MinePressed".position.x = 21
		$"../MinePressed".position.y = 10
		monitoring = false
		monitorable = false
		$CollisionShape2D.set_disabled(true)
