extends Node2D

@onready var anim_1 = $CharacterBody2D/Player_1
@onready var anim_2 = $CharacterBody2D2/Player_2
@onready var anim_3 = $CharacterBody2D3/Player_3
@onready var anim_4 = $CharacterBody2D4/Player_4
@onready var bell_1 = $Bell_1
@onready var bell_2 = $Bell_2
@onready var bell_3 = $Bell_3
@onready var bell_4 = $Bell_4
@onready var bell_5 = $Bell_5
@onready var turn = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_1.play("Idle")
	anim_2.play("Idle")
	anim_3.play("Idle")
	anim_4.play("Idle")
	bell_1.play("Idle")
	bell_2.play("Idle")
	bell_3.play("Idle")
	bell_4.play("Idle")
	bell_5.play("Idle")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var won = false
	var player_1 = $CharacterBody2D
	var player_2 = $CharacterBody2D2
	var player_3 = $CharacterBody2D3
	var player_4 = $CharacterBody2D4

	
	while(won == false):
		if turn == 4 * turn:
			pass
		elif turn == (4 * turn) + 1:
			pass
		elif turn == (4 * turn) + 2:
			pass
		elif turn == (4 * turn) + 3:
			pass
		turn += 1
		won = true
