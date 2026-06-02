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
	display_name:String
	):
		var config=ConfigFile.new()
		var public_id=""
		var load_error=config.load("user://user_profile.cfg")
		if load_error ==  OK and config.has_section_key("identity","public_id"):
			public_id=config.get_value("identity","public_id")
			print("Welcome back "+public_id)
		else:
			public_id=correcing(display_name)+"-"+genrate_suffix()
			config.set_value("identity","public_id",public_id)
			config.save("user://user_profile.cfg")
			print("Id saved permanently "+public_id)
		var user_dynamic_link="https://incog-c7772.web.app/" + public_id
		var dashboard_scene = load("res://Dashboard.tscn")
		var dashboard_instance = dashboard_scene.instantiate()
		if dashboard_instance.has_method("initialize_user_dashboard"):
			dashboard_instance.initialize_user_dashboard(public_id, user_dynamic_link)
		get_tree().root.add_child(dashboard_instance)
		get_tree().current_scene.queue_free()
		get_tree().current_scene = dashboard_instance
		
func _on_sign_in_failed(error:String):
	print(error)
	
func correcing(display_name):
	user_name=display_name.to_lower()
	user_name=user_name.replace(" ","-")
	user_name=user_name.replace("_","-")
	return user_name

func genrate_suffix():
	var chars="qwertyuiopasdfghjklzxcvbnm1234567890"
	var results=""
	for i in range(6):
		results+=chars[randi() % chars.length()]
	return results

func _on_button_pressed() -> void:
	if google_sign_in:
		google_sign_in.signIn()
