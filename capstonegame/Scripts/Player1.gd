extends Node2D

# Declare variables for animations, movement speed, stamina, and current state
@onready var tile_manager = get_node("/root/Main/TileManager")
@onready var tile_paths = tile_manager.tile_paths  # Now correctly referencing the dictionary
@onready var valid_tiles = tile_manager.tile_types
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
var tilemap
var roll_result: int
var steps_taken: int

# Signal to inform when the player's turn has ended
signal turn_ended
signal path_chosen(choice: int)

func _ready():
	# Set up reference to the animated sprite
	animated_sprite = $AnimatedSprite2D
	
	
	# Set up reference to the tilemap
	tilemap = get_node("/root/Main/Board/Land")
	
	# Initialize character's position to (0, 0)
	position = tilemap.map_to_local(Vector2(-2, 0))
	
	# Play idle animation by default
	animated_sprite.play("Idle")

	# Set up references to the UI elements and connect the pressed signals
	roll_button = $UI/Button
	use_stamina_button = $UI/Button2
	stamina_spinbox = $UI/SpinBox
	choice_container = $UI/ChoiceContainer

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

# Internal function to move to the next position in the movement path
func move_to_next_tile(delta):
	print("movement_path", movement_path)
	if movement_path.size() > 0:
		var target_tile: Vector2 = movement_path[0]
		var target_position: Vector2 = tilemap.map_to_local(target_tile)
		var direction: Vector2 = (target_position - position).normalized()
		var distance_to_move: float = move_speed * delta
		if direction < Vector2(0,0):
			print("move left!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			animated_sprite.flip_h = true
		elif direction > Vector2(0,0):
			print("move right!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
			animated_sprite.flip_h = false


		# If the player is close enough to the target tile, snap to it
		if position.distance_to(target_position) <= distance_to_move:
			if tile_paths.has(current_tile):
				var next_tiles = tile_paths[target_tile]
				print("Next_tiles", next_tiles)
				print("tile_path", tile_paths[target_tile])
				print("current_tile", current_tile)
				if next_tiles.size() > 1:  # If there's a fork
					print("a fork is coming!")
					is_moving = false
					animated_sprite.play("Choosing")
					choose_path(next_tiles)  # Pause movement and ask player
					return
					#----------------------------------------------------------------------------------------------------
			position = target_position
			movement_path.pop_front()
			steps_taken += 1
			
			# If there are more tiles to move, continue moving
			if movement_path.size() == 0:
				is_moving = false
				animated_sprite.play("Idle")
				var tile_tag = valid_tiles[current_tile]
				match tile_tag:
					"red":
						if stamina > 0:
							stamina -= 1
					"blue":
						if stamina < max_stamina:
							stamina += 1
				await get_tree().create_timer(3).timeout
				emit_signal("turn_ended")
				print("Stamina", stamina)
				# Re-enable the roll button after the turn ends
				roll_button.disabled = false
				use_stamina_button.disabled = false
		else:
			# Move the player towards the target tile
			position += direction * distance_to_move
			
func choose_path(options: Array):
	# Clear previous buttons before adding new ones
	for child in choice_container.get_children():
		child.queue_free()

	print("Fork detected! Choose a direction:")
	choice_container.visible = true

	for i in range(options.size()):
		var button = Button.new()
		button.text = "Path " + str(i + 1)
		button.pressed.connect(func(): _on_path_selected(i))
		choice_container.add_child(button)

	# Wait for player to make a choice
	var choice = await path_chosen
	current_tile = options[choice]  # The player has selected one of the options
	print("Chosen path:", current_tile)
	
	movement_path.clear()  # Clear the current path
	_create_new_path(current_tile)  # Recursively call _create_new_path to continue movement
	is_moving = true
	animated_sprite.play("Moving")

#new function	
func _create_new_path(start_tile: Vector2):
	var steps_left = (roll_result - steps_taken) - 1 # The number of steps remaining after rolling the dice
	var current_tile = start_tile
	var movement_steps = [current_tile]  # Start by adding the current tile
	while steps_left > 0:
		if tile_paths.has(current_tile):  # Check if there are next possible tiles
			var next_tiles = tile_paths[current_tile]
			var next_tile = next_tiles[0]
			movement_steps.append(next_tile)  # Add the next tile to the movement path
			current_tile = next_tile  # Move to the next tile
			steps_left -= 1  # Decrease the number of steps left
		else:
			break  # No further tiles to move, end the movement path
	
	# If there are steps left after this loop, handle that
	if steps_left > 0:
		print("Not enough tiles to complete the movement.")
	
	# Start the movement with the calculated path
	move_character(movement_steps)

func _on_path_selected(choice: int):
	emit_signal("path_chosen", choice)
	choice_container.visible = false

# Function called when the roll button is pressed
func _on_button_pressed():
	# Disable the roll button to prevent spamming
	roll_button.disabled = true
	use_stamina_button.disabled = true
	roll_result = 100
	#roll_result = randi() % 6 + 1
	print("Rolled: ", roll_result)

	# Add stamina to roll result if spinbox is visible
	var stamina_used = 0
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
