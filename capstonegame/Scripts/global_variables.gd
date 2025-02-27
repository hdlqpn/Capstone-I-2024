extends Node

#TODO Bingo cards instanstiated, Blackout tracker (?), 
#TODO find out how to incorporate these into the game so you can use the other player models
var p1_Model
var p2_Model
var p3_Model
var p4_Model


#Waiting to find out if these need to be arrays or ints, could also be added to the players menus 
var p1_Inv
var p2_Inv
var p3_Inv
var p4_Inv 

# 1-4, Used to track player positions after a minigame
#MAKE SURE TO CHANGE AT END OF GAME
var p1_Place = 1
var p2_Place = 2
var p3_Place = 3
var p4_Place = 4

#Variables if we need to track where someone lands for some reason. Shouldn't need in the current state.
#var p1_Space
#var p2_Space
#var p3_Space
#var p4_Space

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
