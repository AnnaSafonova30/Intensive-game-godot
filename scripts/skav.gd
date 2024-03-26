extends Area2D
var can_click = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire") and can_click:
		get_tree().change_scene_to_file("res://scenes_for_scenes/skins.tscn")


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$Sprite2D.visible = true
		can_click = true


func _on_body_exited(body):
	if body.name == "CharacterBody2D":
		can_click = false
		$Sprite2D.visible = false
