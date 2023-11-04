extends Node

var text = preload("res://text.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var text_instance_1 = text.instantiate()
	text_instance_1.set_position(Vector2(randi_range(100, 1000), randi_range(100, 500)))
	add_child(text_instance_1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
