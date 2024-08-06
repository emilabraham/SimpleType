extends Node2D

var dictionary = []
var sprite
var text

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	set_position(Vector2(randi_range(100, 1000), randi_range(100, 500)))
	sprite = get_node("Enemy1Sprite")
	text = get_node("Enemy1Text")

func remove_word():
	remove_from_group("enemies")
	queue_free()
	get_tree().call_group("enemies", "toggle_deleting")

# We enter deleting mode as we are deleting a text object
# We exit deleting mode as we are getting a new focus
# I noticed when entering the last character, we would inadverdently break the streak
# This method prevents that
func toggle_deleting():
	text.toggle_deleting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
