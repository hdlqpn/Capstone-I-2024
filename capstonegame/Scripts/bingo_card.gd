extends Control


@onready var square_ref_array = [
	$BCPanel/BCVBox/SquareGrid/BingoSquare1,
	$BCPanel/BCVBox/SquareGrid/BingoSquare2,
	$BCPanel/BCVBox/SquareGrid/BingoSquare3,
	$BCPanel/BCVBox/SquareGrid/BingoSquare4,
	$BCPanel/BCVBox/SquareGrid/BingoSquare5,
	$BCPanel/BCVBox/SquareGrid/BingoSquare6,
	$BCPanel/BCVBox/SquareGrid/BingoSquare7,
	$BCPanel/BCVBox/SquareGrid/BingoSquare8,
	$BCPanel/BCVBox/SquareGrid/BingoSquare9,
]

var to_mark_array = []
var new_text_array = []

''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in to_mark_array:
		square_ref_array[i].get_node("MarkerColor").show()

	for i in range(0, square_ref_array.size()):
		square_ref_array[i].get_node("SquareLabel").text = new_text_array[i]


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_close_button_pressed() -> void:
	self.queue_free()
	
