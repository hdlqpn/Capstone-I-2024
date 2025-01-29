extends Control

# This node has the process mode set to ALWAYS

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

''' ---------- SIGNAL FUNCTIONS ---------- '''

# Closes the game without any safeties
func _on_button_pressed() -> void:
	get_tree().quit()
