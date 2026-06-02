extends Control
@onready var link_label: Label = $ScrollContainer/Control/LinkLabel
@onready var share_button: TextureButton = $ScrollContainer/Control/ShareButton
@onready var inbox: VBoxContainer = $ScrollContainer/Control/VBoxContainer
@onready var firebase_messages_request: HTTPRequest = $FirebaseMessagesRequest
@onready var firebase_listener: Node = $FirebaseListener

const MESSAGE_CARD=preload("res://panel.tscn")
var current_public_id: String = ""
var my_shareable_link: String = ""

func _ready() -> void:
	get_tree().set_quit_on_go_back(true)
	firebase_messages_request.request_completed.connect(_on_messages_recieved)
	if my_shareable_link != "":
		if my_shareable_link.length() > 13:
			link_label.text = my_shareable_link.substr(0, 13) + "..."
		else:
			link_label.text = my_shareable_link
	firebase_listener.start_stream(current_public_id)
	fetch_messages()
	
	
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
			
func initialize_user_dashboard(public_id: String, dynamic_link: String) -> void:
	print("Initialize user dashboard working with link: "+ dynamic_link)
	current_public_id = public_id
	my_shareable_link = dynamic_link
	
func fetch_messages():
	if current_public_id=="":
		print("No public id found")
		return
	var url="https://incog-c7772-default-rtdb.asia-southeast1.firebasedatabase.app/users/"+current_public_id+"/messages.json"
	print("URL: "+url)
	firebase_messages_request.request(url)
	
func _on_messages_recieved(result:int,response_code:int,headers:PackedStringArray,body:PackedByteArray):
	if response_code==200:
		var json_string=body.get_string_from_utf8()
		var json=JSON.new()
		print("RAW JSON:")
		print(json_string)
		var parse_result=json.parse(json_string)
		if parse_result==OK:
			var data=json.get_data()
			if data!=null and data is Dictionary:
				for message_key in data:
					var msg_data=data[message_key]
					var card=MESSAGE_CARD.instantiate()
					inbox.add_child(card)
					card.setup_card(msg_data["text"],msg_data["time"])
			else:
				print("Inbox empty")
		else:
			print("Failed",response_code)
			print("JSON error line:", json.get_error_line())
			print("JSON error message:", json.get_error_message())
