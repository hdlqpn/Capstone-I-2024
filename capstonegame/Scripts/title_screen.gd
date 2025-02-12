extends Control

func _on_play_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
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
	
func _on_game_2_bell_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	get_tree().change_scene_to_file("res://minigames/Mash_Game_2.tscn")
	
func _on_game_3_platform_pressed() -> void:
	AudioManager.play_audio(SoundEffects.sound_effect_name.BUTTON) #Test Sound
	get_tree().change_scene_to_file("res://minigames/Platform_Game_3.tscn")
