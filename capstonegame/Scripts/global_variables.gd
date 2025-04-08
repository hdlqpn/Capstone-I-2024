extends Node

var turnNum = 0

func minigameStart(turn: int) -> void:
	if turn % 4 == 0:
		get_tree().change_scene_to_file("res://minigames/Mash_Game_2.tscn")
		return
	else:
		return #do nothing
		

#TODO Bingo cards instanstiated, Blackout tracker (?), 
#TODO find out how to incorporate these into the game so you can use the other player models
var p1_Model
var p2_Model
var p3_Model
var p4_Model
#This is set to the initial position and updated accordingly
var p1_Pos: Vector2 = Vector2(-2, 0)
var p2_Pos: Vector2 = Vector2(-1, 0)
var p3_Pos: Vector2 = Vector2(0, 0)
var p4_Pos: Vector2 = Vector2(1, 0)

#Waiting to find out if these need to be arrays or ints, could also be added to the players menus 
var p1_Inv
var p2_Inv
var p3_Inv
var p4_Inv 

# 1-4, Used to track player places after a minigame
#MAKE SURE TO CHANGE AT END OF GAME
var p1_Place = 1
var p2_Place = 2
var p3_Place = 3
var p4_Place = 4

#Roll Variable
func rollNum() -> int:
	var result = randi_range(1,6)
	return result
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HudCanvasLayer.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_debug_menu_enable_hud() -> void:
	if $HudCanvasLayer.visible:
		$HudCanvasLayer.hide()
	else:
		$HudCanvasLayer.show()


# call with contents as a string, sprite as a string reference to the asset
func create_text_bubble(contents = "default text", sprite = "res://characters/Player_1/SpookyP1.png"):
	$CanvasLayer/DebugMenu.debug_create_text_bubble(contents, sprite)


# Plays the animation when changing scenes. direction_bool = true is forward, false is backward
func play_scene_transition(direction_bool, speed_scale):
	$CanvasLayer/SceneTransitionPlayer.set_speed_scale(speed_scale)
	if direction_bool:
		$CanvasLayer/SceneTransitionPanel.show()
		$CanvasLayer/SceneTransitionPlayer.play("scene_transition")
	else:
		$CanvasLayer/SceneTransitionPlayer.play_backwards("scene_transition")
		await $CanvasLayer/SceneTransitionPlayer.animation_finished
		$CanvasLayer/SceneTransitionPanel.hide()
