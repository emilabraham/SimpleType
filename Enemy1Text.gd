extends "res://text.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent_position = get_parent().position
	set_position(Vector2(parent_position.x, parent_position.y))
	load_dictionary()
	set_word(pick_word())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
