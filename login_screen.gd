extends Control
@onready var google_login_button: Button = $MainLayout/ContentStack/GoogleLoginButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().set_quit_on_go_back(true)
	
func _on_google_login_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://Dashboard.tscn")
