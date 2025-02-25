extends Node2D

# Declare variables for animations, movement speed, stamina, and current state
var animated_sprite: AnimatedSprite2D
var current_tile: Vector2 = Vector2(-2, 0)
var move_speed: float = 100.0
var is_moving: bool = false
var movement_path: Array = []
var roll_button: Button
var use_stamina_button: Button
var stamina_spinbox: SpinBox
var choice_container: VBoxContainer
var stamina: int = 3
var max_stamina: int = 10
var stamina_used = 0
var tilemap
var roll_result: int
var steps_taken: int
# Define a dictionary to store the valid tiles
var valid_tiles: Dictionary = {
	Vector2(0, -1): "blue",
	Vector2(0, -2): "blue",
	Vector2(0, -3): "blue",
	Vector2(0, -4): "red",
	Vector2(0, -5): "blue",
	Vector2(0, -6): "blue",
	Vector2(0, -7): "red",
	Vector2(0, -8): "blue",
	Vector2(0, -9): "green",
	Vector2(-1, -9): "blue",
	Vector2(-2, -9): "blue",
	Vector2(-3, -9): "blue",
	Vector2(-4, -9): "red",
	Vector2(-5, -9): "blue",
	Vector2(-5, -10): "blue",
	Vector2(-5, -11): "red",
	Vector2(-5, -12): "blue",
	Vector2(-5, -13): "blue",
	Vector2(-5, -14): "red",
	Vector2(-5, -15): "blue",
	Vector2(-4, -15): "blue",
	Vector2(-3, -15): "blue",
	Vector2(-2, -15): "red",
	Vector2(-1, -15): "blue",
	Vector2(-0, -15): "green",
	Vector2(1, -15): "red",
	Vector2(2, -15): "blue",
	Vector2(3, -15): "blue",
	Vector2(4, -15): "red",
	Vector2(5, -15): "blue",
	Vector2(5, -16): "blue",
	Vector2(5, -17): "red",
	Vector2(5, -18): "blue",
	Vector2(5, -19): "blue",
	Vector2(5, -20): "blue",
	Vector2(5, -21): "red",
	Vector2(4, -21): "blue",
	Vector2(3, -21): "blue",
	Vector2(2, -21): "red",
	Vector2(1, -21): "blue",
	Vector2(0, -21): "blue",
	Vector2(0, -22): "red",
	Vector2(0, -23): "blue",
	Vector2(0, -24): "red",
	Vector2(0, -25): "blue",
	Vector2(0, -26): "End",
	# Add more tiles as needed
}

# Signal to inform when the player's turn has ended
signal turn_ended

func _ready():
	# Set up reference to the animated sprite
	animated_sprite = $AnimatedSprite2D
	
	# Set up reference to the tilemap
	tilemap = get_node("/root/Main/Board/Land")
	
	# Initialize character's position to (0, 0)
	position = tilemap.map_to_local(Vector2(1, 0))
	
	# Play idle animation by default
	animated_sprite.play("Idle")

	# Set up references to the UI elements and connect the pressed signals
	roll_button = $UI/Button
	use_stamina_button = $UI/Button2
	stamina_spinbox = $UI/SpinBox

	# Hide stamina spinbox at the start
	stamina_spinbox.visible = false
	stamina_spinbox.min_value = 0
	stamina_spinbox.max_value = stamina


# Function to initiate movement to the target positions in the dictionary
func move_character(movement_steps: Array):
	# Append all new movement steps to the movement path
	for step in movement_steps:
		movement_path.append(step)
	
	# Begin movement if character is not already moving
	if not is_moving:
		start_moving()

# Internal function to start movement animation
func start_moving():
	if movement_path.size() > 0:
		is_moving = true
		animated_sprite.play("Moving")

func _process(delta):
	if is_moving:
		move_to_next_tile(delta)
	$UI/RollCounter.text = str(roll_result)

# Internal function to move to the next position in the movement path
func move_to_next_tile(delta):
	if movement_path.size() == 0 and valid_tiles.has(current_tile):
		var tile_tag = valid_tiles[current_tile]
		match tile_tag:
			"red":
				if stamina > 0:
					stamina -= 1
			"blue":
				if stamina < max_stamina:
					stamina += 1
			"green":
				var keys = valid_tiles.keys()
				var next_tile_index = keys.find(current_tile) + 15
				if next_tile_index < keys.size():
					current_tile = keys[next_tile_index]
					movement_path.append(current_tile)
	if movement_path.size() > 0:
		var target_tile: Vector2 = movement_path[0]
		var target_position: Vector2 = tilemap.map_to_local(target_tile)
		var direction: Vector2 = (target_position - position).normalized()
		var distance_to_move: float = move_speed * delta

		# If the player is close enough to the target tile, snap to it
		if position.distance_to(target_position) <= distance_to_move:
			position = target_position
			roll_result -= 1
			movement_path.pop_front()

			# If there are more tiles to move, continue moving
			if movement_path.size() == 0:
				is_moving = false
				animated_sprite.play("Idle")
				await get_tree().create_timer(3).timeout
				emit_signal("turn_ended")
				# Re-enable the roll button after the turn ends
				roll_button.disabled = false
				use_stamina_button.disabled = false
		else:
			# Move the player towards the target tile
			position += direction * distance_to_move

# Function called when the roll button is pressed
func _on_button_pressed():
	# Disable the roll button to prevent spamming
	roll_button.disabled = true
	use_stamina_button.disabled = true
	roll_result = GlobalVariables.rollNum()
	print("Rolled: ", roll_result)

	# Add stamina to roll result if spinbox is visible
	stamina_used = 0
	if stamina_spinbox.visible:
		stamina_used = stamina_spinbox.value
		stamina -= stamina_used
		stamina_spinbox.max_value = stamina  # Update spinbox max value
	
	print("Stamina used: ", stamina_used)
	roll_result += stamina_used

	# Create movement steps based on the roll result
	var movement_steps = []
	var keys = valid_tiles.keys()
	var next_tile_index = keys.find(current_tile) + 1

	for i in range(roll_result):
		if next_tile_index < keys.size():
			var next_tile = keys[next_tile_index]
			movement_steps.append(next_tile)
			next_tile_index += 1

	move_character(movement_steps)
	current_tile = movement_steps[-1] if movement_steps.size() > 0 else current_tile
	
	#Fade out all UI Once roll is pressed
	var tween = create_tween()
	tween.tween_property(roll_button, "modulate:a", 0.0, 0.5)
	tween.tween_property(use_stamina_button, "modulate:a", 0.0, 0.5)
	tween.tween_property(stamina_spinbox, "modulate:a", 0.0, 0.5)

# Function called when the use stamina button is pressed
func _on_use_stamina_pressed():
	stamina_spinbox.modulate.a = 0.0
	stamina_spinbox.visible = true

	# Set up a tween to fade out the button and fade in the spinbox
	var tween = create_tween()
	tween.tween_property(use_stamina_button, "modulate:a", 0.0, 0.5)
	tween.tween_property(stamina_spinbox, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

# Function to set the player as active or inactive
func set_active(is_active: bool):
	set_process(is_active)
	if is_active:
		animated_sprite.play("Idle")
	else:
		animated_sprite.stop()
