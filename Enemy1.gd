extends CharacterBody2D

signal damage_ship

var sprite
var text
var speed = 0.1
var ship
var starting_position
var goal_position

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	set_position(Vector2(randi_range(100, 500), 0))
	starting_position = position
	goal_position = Vector2(300, 700)
	sprite = get_node("Enemy1Sprite")
	text = get_node("Enemy1Text")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)

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

func move(delta):
	var enemy1_vector = (goal_position - starting_position) * speed
	var collision = move_and_collide(enemy1_vector * delta)
	if (collision != null && ship == collision.get_collider()):
		text.break_streak.emit()
		remove_word()
		damage_ship.emit()
