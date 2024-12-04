extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left_player_3", "ui_right_player_3")
	var move_anim = $Player_3
	
	if direction:
		print(direction)
		velocity.x = direction * SPEED
		if direction > 0:
			$Player_3.flip_h = false
			move_anim.play("Move")
		elif direction < 0:
			$Player_3.flip_h = true
			move_anim.play("Move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_anim.play("Choosing")
		

	move_and_slide()
