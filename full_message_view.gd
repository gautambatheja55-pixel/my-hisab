extends Control
@onready var label: Label = $ContentLayout/Label


func _ready() -> void:
	label.text=MessageData.selected_message
	get_tree().set_quit_on_go_back(false)

func _notification(what: int) -> void:
	if what== NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().change_scene_to_file("res://Dashboard.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Dashboard.tscn")
