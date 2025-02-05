extends Control

''' This node has the process mode set to ALWAYS '''

# Node Reference
@onready var text_node = $MarginContainer/NinePatchRect/Panel/RichTextLabel


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if text_node.visible_characters < text_node.text.length():
		text_node.visible_characters += 1


''' ---------- CUSTOM FUNCTIONS ---------- '''

# Function run by other scenes to update the text
func update_text(new_text):
	$MarginContainer/NinePatchRect/Panel/RichTextLabel.text = new_text
	
# Deletes the text bubble when clicked
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			queue_free()
