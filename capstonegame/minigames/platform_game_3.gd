extends Node2D


@onready var cloud = $Cloud_1/StaticBody2D/Cloud
@onready var cloud_2 = $Cloud_2/StaticBody2D/Cloud
@onready var cloud_3 = $Cloud_3/StaticBody2D/Cloud
@onready var anim_1 = $P1/CharacterBody2D/Player_1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_1.play("Idle")
	cloud.play("Idle")
	cloud_2.play("Idle")
	cloud_3.play("Idle")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		
