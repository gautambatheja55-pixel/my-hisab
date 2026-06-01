extends Panel
@onready var label: Label = $Label
@onready var time_label: Label = $TimeLabel

var full_message=""
var TIME=""

func _ready() -> void:
	pass
	
func _on_button_pressed() -> void:
	MessageData.selected_message=full_message
	MessageData.selected_time=TIME
	get_tree().call_deferred("change_scene_to_file","res://full_message_view.tscn")
	
func setup_card(message_text,time_text):
	full_message=message_text
	TIME=time_text
	if message_text.length()>=12:
		label.text=message_text.substr(0,12) + "..."
		time_label.text=time_text
	else:
		label.text=message_text
		time_label.text=time_text
