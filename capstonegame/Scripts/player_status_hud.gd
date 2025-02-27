extends Control


@export var player_icon = load("res://characters/Player_1/justaguy.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Panel/Panel/Sprite2D.texture = player_icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
