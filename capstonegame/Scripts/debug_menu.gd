extends Control

''' This node has the process mode set to ALWAYS '''

# Scene Loading
var text_window_scene = load("res://Scenes/text_window.tscn")
var bingo_card_scene = load("res://Scenes/bingo_card.tscn")

# Signals
signal enable_hud


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_debug"):
		pause()


''' ---------- CUSTOM FUNCTIONS ---------- '''

# If paused: unpause. If unpaused: pause.
func pause():
	if get_tree().paused == true:
		get_tree().paused = false
		hide()
	else:
		get_tree().paused = true
		show()

# Call with Global's create_text_menu
func debug_create_text_bubble(contents, sprite):
	var next_message = text_window_scene.instantiate()
	next_message.update_text(contents)
	next_message.update_sprite(sprite)
	next_message.process_mode = PROCESS_MODE_ALWAYS # Sets process to always because the debug menu pauses all function otherwise
	
	get_parent().add_child(next_message)


''' ---------- SIGNAL FUNCTIONS ---------- '''

# Closes the game without any safeties
func _on_button_pressed() -> void:
	get_tree().quit()


func _on_text_button_pressed() -> void:
	var next_message_text = $DbPanel/DbBox/DbCol/DbCol3/TextContent.text
	
	# Doing it bad here to show how its supposed to be done elsewhere
	GlobalVariables.create_text_bubble(next_message_text, "res://characters/Player_1/RaddicusP1.png")


func _on_bingo_button_pressed() -> void:
	if $BingoCardMaker.visible:
		$BingoCardMaker.hide()
	else:
		$BingoCardMaker.show()
	
	#next_bingo_card.process_mode = PROCESS_MODE_ALWAYS # Sets process to always because the debug menu pauses all function otherwise
	#get_parent().add_child(next_bingo_card)


func _on_spawn_card_button_pressed() -> void:
	var next_bingo_card = bingo_card_scene.instantiate()
	
	var squares_checked_list = []
	var squares_text_list = []
	var index_num = 0
	for i in $BingoCardMaker/ScrollContainer/BCMVBox.get_children().slice(1):
		if i.get_node("CheckBox").button_pressed:
			squares_checked_list.append(index_num)
			
		squares_text_list.append(i.get_node("TextEdit").text)
		
		index_num += 1
	
	next_bingo_card.to_mark_array = squares_checked_list
	next_bingo_card.new_text_array = squares_text_list
	
	next_bingo_card.process_mode = PROCESS_MODE_ALWAYS
	get_parent().add_child(next_bingo_card)


func _on_enable_hud_pressed() -> void:
	enable_hud.emit()
