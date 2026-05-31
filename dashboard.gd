extends Control
@onready var link_label: Label = $ScrollContainer/Control/LinkLabel
@onready var share_button: TextureButton = $ScrollContainer/Control/ShareButton
@onready var inbox: VBoxContainer = $ScrollContainer/Control/VBoxContainer

const MESSAGE_CARD=preload("res://panel.tscn")

var messages=[
	{"text":"Who's your crush?",
	"time":"1 min ago"}
	,
	{"text":"Favourite Teacher?",
	"time":"5 min ago"}
	,
	{"text":"ek baccha kedernath mai ghanti nhi baja paa rha hai",
	"time":"15 min ago"}]

func _ready() -> void:
	for msg in messages:
		var card=MESSAGE_CARD.instantiate()
		inbox.add_child(card)
		card.setup_card(
			msg["text"],
			msg["time"]
		)
		
	get_tree().set_quit_on_go_back(true)
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
	
	
