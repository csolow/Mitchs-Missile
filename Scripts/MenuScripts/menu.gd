extends Control

@export var address = "127.0.0.1"
@export var port = 8910
var peer
# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu/StartGame.grab_focus()
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#multiplayer functions
func peer_connected(id):
	print("Player Connected " + str(id))


func peer_disconnected(id):
	print("Player Disconnected " + str(id))

func connected_to_server():
	print("Connected To Server!")
	send_player_information.rpc_id(1, $LineEdit.text, multiplayer.get_unique_id())

func connection_failed():
	print("Couldnt Connect")

@rpc("any_peer","call_local")
func start_game():
	var scene = load("res://Scenes/main.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

@rpc("any_peer")
func send_player_information(name, id):
	if !GameManager.players.has(id):
		GameManager.players[id] ={
			"name" : name,
			"id" : id
		}
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_information.rpc(GameManager.players[i].name, i)

#Button functions
func _on_start_game_button_down():
	start_game.rpc()
	pass # Replace with function body.

func _on_host_button_button_down():
	peer = ENetMultiplayerPeer.new()
	#anden parameter er mængden af spillere
	var error = peer.create_server(port, 3)
	if error != OK:
		print("Cannot Host: ", error)
		return
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting For Players!")
	send_player_information($LineEdit.text, multiplayer.get_unique_id())
	pass # Replace with function body.

func _on_join_button_button_down():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)
	pass # Replace with function body.

func _on_training_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
