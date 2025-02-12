extends Resource
class_name SoundEffects
enum sound_effect_name{  #all sound Names
	BUTTON,
	TEST
}

@export var name : sound_effect_name
@export var sound_effect : AudioStreamMP3
@export var volume = 0
@export var pitch_scale = 1.0
	
