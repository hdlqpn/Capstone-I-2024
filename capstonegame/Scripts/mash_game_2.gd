extends Node2D


@onready var anim_1 = $P1/CharacterBody2D/Player_1
@onready var one_presses = $Bag_1
@onready var anim_2 = $P2/CharacterBody2D2/Player_2
@onready var anim_3 = $P3/CharacterBody2D3/Player_3
@onready var anim_4 = $P4/CharacterBody2D4/Player_4
@onready var bag_1 = $Bag_1/Bag
@onready var bag_2 = $Bag_2/Bag
@onready var bag_3 = $Bag_3/Bag
@onready var bag_4 = $Bag_4/Bag
@onready var timer = $Timer
@onready var timer_sec = $Timer/Seconds
@onready var win_label = $Winner
var p1_mash_amt: int = 0
var p2_mash_amt: int = 0
var p3_mash_amt: int = 0
var p4_mash_amt: int = 0
var is_most: int = -1
var p1_win = false
var p2_win = false
var p3_win = false
var p4_win = false
var leader: int = 1 #p1 wins by default
var leader_score: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_label.visible = false
	anim_1.play("Idle")
	anim_2.play("Idle")
	anim_3.play("Idle")
	anim_4.play("Idle")
	bag_1.play("Idle")
	bag_2.play("Idle")
	bag_3.play("Idle")
	bag_4.play("Idle")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	
	#Checks input and not hitbox. Will have to change later at some point.
	if(timer.visible == true):
		if Input.is_action_just_pressed("player_1_punch"):
			p1_mash_amt += 1
		if Input.is_action_just_pressed("player_2_punch"):
			p2_mash_amt += 1
		if Input.is_action_just_pressed("player_3_punch"):
			p3_mash_amt += 1
		if Input.is_action_just_pressed("player_4_punch"):
			p4_mash_amt += 1

		if p1_mash_amt > (leader_score + 1):
			leader = 1
			leader_score = p1_mash_amt
		if p2_mash_amt > (leader_score + 1):
			leader = 2
			leader_score = p3_mash_amt
		if p3_mash_amt > (leader_score + 1):
			leader = 3
			leader_score = p3_mash_amt
		if p4_mash_amt > (leader_score + 1):
			leader = 4
			leader_score = p4_mash_amt
			
	if(timer_sec.text == "00:"):
		if leader == 1:
			p1_win = true
			timer.visible = false
			win_label.text = "Player 1 Wins"
			win_label.visible = true
			await get_tree().create_timer(5).timeout
			#get_tree().quit()
			get_tree().change_scene_to_file("res://Scenes/Main.tscn")
		elif leader == 2:
			p2_win = true
			timer.visible = false
			win_label.text = "Player 2 Wins"
			win_label.visible = true
			await get_tree().create_timer(5).timeout
			#get_tree().quit()
			get_tree().change_scene_to_file("res://Scenes/Main.tscn")
		elif leader == 3:
			p3_win = true
			timer.visible = false
			win_label.text = "Player 3 Wins"
			win_label.visible = true
			await get_tree().create_timer(5).timeout
			get_tree().change_scene_to_file("res://Scenes/Main.tscn")
			#get_tree().quit()
		elif leader == 4:
			p4_win = true
			timer.visible = false
			win_label.text = "Player 4 Wins"
			win_label.visible = true
			await get_tree().create_timer(5).timeout
			#get_tree().quit()
			get_tree().change_scene_to_file("res://Scenes/Main.tscn")
	
		
		
		
