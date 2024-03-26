extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	if OS.get_name() == "Windows" or OS.get_name() == "OSX":
		texture = load("res://resources/ui/keyboard/f.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
