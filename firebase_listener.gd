extends Node
var client=HTTPClient.new()
var current_public_id=""
var is_connected_to_stream=false

func _ready() -> void:
	pass # Replace with function body.
	
func start_stream(public_id):
	print("start stream func running")
	current_public_id=public_id
	var host="https://console.firebase.google.com/u/0/project/incog-c7772/database/incog-c7772-default-rtdb/data/~2F"
	var port=443
	var tls = TLSOptions.client()
	var error=client.connect_to_host(host,port,tls)
	
	if error != OK:
		print("Handshake failed")
		

func _process(_delta: float) -> void:
	#if current_public_id=="":
		#return
	client.poll()
	var status=client.get_status()
	if status==HTTPClient.STATUS_CONNECTING:
		print("recieving...")
	elif status==HTTPClient.STATUS_CONNECTED:
		print("Sucess!")
		current_public_id=""
	elif status==HTTPClient.STATUS_CANT_CONNECT:
		print("Cant connect")
	
	
	
	
	
	
	
	
	
	
	
