extends Label
var export_config = ConfigFile.new()
var export_config_path = "res://export_presets.cfg"
var config_error = export_config.load(export_config_path)
# Called when the node enters the scene tree for the first time.
func _ready():
	print(export_config.get_value("preset.0.options", "application/product_version"))
	text = "Game Version: %s"%export_config.get_value("preset.0.options", "application/product_version")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
