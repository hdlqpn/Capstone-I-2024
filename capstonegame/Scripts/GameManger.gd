extends Node

# Array to hold references to all players
var players: Array = []
var current_player_index: int = 0

func _ready():
	# Add references to all players
	players = [
		get_node("/root/Main/Player1"),
		get_node("/root/Main/Player2"),
		get_node("/root/Main/Player3"),
		get_node("/root/Main/Player4")
	]
	
	# Start with Player 1
	activate_player(current_player_index)

func activate_player(index):
	# Deactivate all players
	for player in players:
		player.get_node("UI").visible = false
		player.get_node("Camera2D").visible = false
		player.set_process(false)

	# Activate the current player
	var active_player = players[index]
	var camera = active_player.get_node("Camera2D")
	camera.make_current()
	camera.zoom = Vector2(20, 20)  # Zoom in to 0.5x (smaller values mean closer zoom)
	active_player.set_process(true)
	
	# Fade in the UI using a tween
	active_player.get_node("UI").visible = true
	var rollDice = active_player.get_node("UI/Button")
	var useStamina = active_player.get_node("UI/Button2")
	
	rollDice.modulate.a = 0.0
	rollDice.visible = true
	
	useStamina.modulate.a = 0.0
	useStamina.visible = true
	var tween = create_tween()
	
	tween.tween_property(rollDice, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(useStamina, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	

# Function called when a player's turn ends
func _on_turn_ended():
	# Move to the next player
	current_player_index = (current_player_index + 1) % players.size()
	activate_player(current_player_index)
