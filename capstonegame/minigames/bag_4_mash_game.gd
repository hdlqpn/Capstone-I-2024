extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_area_entered(area: Area2D) -> void:
	var bag_4 = $Bag
	if area.is_in_group("Player_4"):
		bag_4.play("Hit")
