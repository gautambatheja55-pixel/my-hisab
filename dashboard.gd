extends Control
@onready var link_label: Label = $ScrollContainer/Control/LinkLabel
@onready var share_button: TextureButton = $ScrollContainer/Control/ShareButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	link_label.text="http://gautam/incog.com"

func _on_texture_button_pressed() -> void:
	DisplayServer.clipboard_set(link_label.text)

func _on_share_button_pressed() -> void:
	var share_text="Send me anonymous messages! " + link_label.text
	
	if OS.get_name()=="Android":
		if Engine.has_singleton("SharePlugin"):
			var share_plugin = Share.new()
			add_child(share_plugin)
			share_plugin.share_text(
				"",
				"",
				share_text
			)
	
	
