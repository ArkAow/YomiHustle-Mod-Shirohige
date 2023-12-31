extends Control

onready var lobby_list = $"%LobbyList"
onready var lobby_name = $"%LobbyName"

var selected_lobby
var lobbies = []

func _ready():
	$"%CreateLobbyButton".connect("pressed", self, "_on_create_lobby_button_pressed")

	SteamLobby.connect("lobby_match_list_received", self, "_on_lobby_match_list_received", [], CONNECT_DEFERRED)
	$"%BackButton".connect("pressed", self, "_on_back_button_pressed")

func _on_create_lobby_button_pressed():
	var availability
	if $"%PublicButton".pressed:
		availability = SteamLobby.LOBBY_AVAILABILITY.PUBLIC
	else :
		availability = SteamLobby.LOBBY_AVAILABILITY.FRIENDS
	SteamLobby.LOBBY_NAME = get_lobby_name()
	SteamLobby.create_lobby(availability)

func _on_back_button_pressed():
	Network.stop_multiplayer()
	get_tree().reload_current_scene()

func show():
	.show()
	$"%ConnectingLabel".show()
	clear_lobby_list()
	SteamLobby.request_lobby_list()


func get_lobby_name():
	var lobby_text = lobby_name.text.strip_edges()
	if lobby_text == "":
		return SteamHustle.STEAM_NAME + "'s Lobby"
	return lobby_text

func clear_lobby_list():
	for child in lobby_list.get_children():
		child.free()

func _on_lobby_match_list_received(lobbies):
	self.lobbies = lobbies
	$"%ConnectingLabel".hide()
	

	clear_lobby_list()
	for lobby in lobbies:
		
		var lobby_name:String = Steam.getLobbyData(lobby, "name")

		var lobby_version:String = Steam.getLobbyData(lobby, "version")
		
		if lobby_version != Global.VERSION:
			if $"%FilterIncompatibleButton".pressed:
				continue
		
		
		var lobby_num_members:int = Steam.getNumLobbyMembers(lobby)
		
		var lobby_entry = preload("res://ui/SteamLobby/LobbyEntry.tscn").instance()
		lobby_list.add_child(lobby_entry)
		lobby_entry.connect("selected", self, "_on_lobby_clicked", [lobby_entry])
		var data = {
			"name":lobby_name, 

			"version":lobby_version, 
			"player_count":lobby_num_members, 
			"max_players":SteamLobby.LOBBY_MAX_MEMBERS, 
			"id":lobby, 
		}
		lobby_entry.set_data(data)
		if lobby == selected_lobby:
			lobby_entry.select()
		pass
	yield (get_tree().create_timer(1.0), "timeout")
	SteamLobby.request_lobby_list()

func _on_lobby_clicked(entry):
	if SteamLobby.LOBBY_ID != 0:
		return 
	for lobby in lobby_list.get_children():
		if lobby != entry:
			lobby.deselect()
	if entry.lobby_data.version != Global.VERSION:
		error("Mismatched versions. Make sure your game is fully updated, or you both have the same mods enabled.")
		return 
	selected_lobby = entry.lobby_id
	SteamLobby.join_lobby(entry.lobby_id)
	$"%LobbyList".hide()
	$"%LobbyConnectingLabel".show()

func error(text):
	$"%ErrorLabel".text = text

func _on_SteamLobbyList_visibility_changed():
	if not visible:
		$"%RefreshTimer".stop()
	pass

func _on_FilterIncompatibleButton_toggled(button_pressed):
	_on_lobby_match_list_received(lobbies)
