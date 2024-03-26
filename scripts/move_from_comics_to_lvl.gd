extends TextureButton

@export var levelTeleport = 'second_LVL'
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#rotation += 0.1


#func _on_area_2d_body_entered(body):
	#if body.name == 'CharacterBody2D':
		#get_tree().change_scene_to_file("res://main_scenes/%s.tscn"%levelTeleport)
	#get_tree().change_scene_to_file("res://main_scenes/third_lvl.tscn")
	#get_tree().change_scene_to_file("res://main_scenes/fourth_level.tscn")
	#get_tree().change_scene_to_file("res://main_scenes/cloudlvl.tscn")
	#get_tree().change_scene_to_file("res://main_scenes/lvlsChoice.tscn")


func _on_pressed():
	get_tree().change_scene_to_file("res://main_scenes/%s.tscn"%levelTeleport)
