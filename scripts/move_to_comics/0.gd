extends TextureButton
var listComics = ['prologue', "cold", "acid", "jungle", "cloud", "last"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://scenes_for_scenes/comics/comics_to_%s.tscn"%listComics[int($Label.text)])
