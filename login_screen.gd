extends Control
@onready var google_login_button: Button = $MainLayout/ContentStack/GoogleLoginButton
var user_name=null
var google_sign_in=null

func _ready() -> void:
	get_tree().set_quit_on_go_back(true)
	if OS.get_name()=="Android" and Engine.has_singleton("GodotGoogleSignIn"):
		google_sign_in=Engine.get_singleton("GodotGoogleSignIn")
		google_sign_in.sign_in_success.connect(_on_sign_in_success)
		google_sign_in.sign_in_failed.connect(_on_sign_in_failed)	
		google_sign_in.initialize(
			"987101017989-kbv8ukobfpk44hv5dt7ikn2lm4rii600.apps.googleusercontent.com"
		)
		
func _on_google_login_button_pressed() -> void:
	if google_sign_in:
		google_sign_in.signIn()
		
func _on_sign_in_success(
	id_token:String,
	email:String,
	display_name:String):
	get_tree().call_deferred("change_scene_to_file","res://Dashboard.tscn")
	

func _on_sign_in_failed(error:String):
	print(error)
	
func correcing(display_name):
	user_name=display_name.to_lower()
	user_name=user_name.replace(" ","-")
	user_name=user_name.replace("_","-")
	var regex = RegEx.create_from_string("[^a-z0-9-]")
	return regex.replace(user_name, "", true)

func _on_button_pressed() -> void:
	if google_sign_in:
		google_sign_in.signIn()
