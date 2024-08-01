extends Node2D

var dictionary = []
var sprite
var text

# Called when the node enters the scene tree for the first time.
func _ready():
	set_position(Vector2(randi_range(100, 1000), randi_range(100, 500)))
	sprite = get_node("Enemy1Sprite")
	text = get_node("Enemy1Text")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
