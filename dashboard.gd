extends Control
@onready var link_label: Label = $LinkLabel
@onready var share_button: TextureButton = $ShareButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	link_label.text="http://gautam/incog.com"

func _on_texture_button_pressed() -> void:
	DisplayServer.clipboard_set(link_label.text)

func _on_share_button_pressed() -> void:
	var share_text="Send me anonymous messages! " + link_label.text
	
	if OS.get_name()=="Android":
		if Engine.has_singleton("AndroidShare"):
			var share_plugin=Engine.get_singleton("AndroidShare")
			share_plugin.share_text("My InCog Link","Share Link",share_text)
		else:
			DisplayServer.clipboard_set(share_text)
	else:
		DisplayServer.clipboard_set(share_text)
		
