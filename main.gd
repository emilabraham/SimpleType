extends Node



# Called when the node enters the scene tree for the first time.
func _ready():
	var text = preload("res://text.tscn").instantiate()
#	text.set_position(Vector2(randi_range(100, 1000), randi_range(100, 500)))
	add_child(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
