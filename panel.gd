extends Panel
@onready var label: Label = $Label
var full_message=""
var TIME=""

func _ready() -> void:
	pass
	
func _on_button_pressed() -> void:
	MessageData.selected_message=full_message
	get_tree().change_scene_to_file("res://full_message_view.tscn")
	
func setup_card(message_text,time_text):
	full_message=message_text
	TIME=time_text
	if message_text.length()>5:
		label.text=message_text.substr(0,8) + "-"+time_text
	else:
		label.text=message_text
