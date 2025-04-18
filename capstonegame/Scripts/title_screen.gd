extends Control

func _on_play_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	# Plays scene transition animation
	GlobalVariables.play_scene_transition(true, 1)
	await GlobalVariables.get_node("CanvasLayer/SceneTransitionPlayer").animation_finished
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")

func _on_options_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	#pass # Replace with function body.

func _on_quit_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	get_tree().quit()
 
func _on_game_1__bell_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	get_tree().change_scene_to_file("res://minigames/Bell_Game_1.tscn")
	
func _on_game_3_platform_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	get_tree().change_scene_to_file("res://minigames/Platform_Game_3.tscn")
