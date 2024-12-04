extends Node2D

func _physics_process(delta: float) -> void:
	var hitbox = $CharacterBody2D3/Hitbox_1/Hitbox_1_1
	hitbox.disabled = true
	var time_start = 0
	var time_now = 0
	var player_3 = $CharacterBody2D3/Player_3
	var is_punching = false
	if Input.is_action_just_pressed("player_3_punch"):  # Replace with your action name
		if not is_punching:
			punch_action(player_3, hitbox)
			is_punching = true
	# Check if the button has been released
	if Input.is_action_just_released("player_3_punch"):  # Replace with your action name
		is_punching = false
		#time_start = Time.get_ticks_msec()
		#time_now = Time.get_ticks_msec()
		#var time_elapsed = time_now - time_start
		#if time_elapsed < 1:
		await get_tree().create_timer(1).timeout
		player_3.play("Idle")
	
func punch_action(player, hitbox):
	var end_frame_player = 2
	player.play("Punch")
	_on_player_3_animation_finished(hitbox)

func _on_player_3_animation_finished(hitbox) -> void:
	hitbox.disabled = false
