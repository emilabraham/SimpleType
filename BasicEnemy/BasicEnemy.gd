extends CharacterBody2D

signal damage_ship

var sprite: Sprite2D
var text: Label
var speed: float = 0.01
var ship: CharacterBody2D
var starting_position: Vector2
var goal_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	set_position(Vector2(randi_range(100, 500), 0))
	starting_position = position
	goal_position = Vector2(300, 700)
	sprite = get_node("BasicEnemySprite")
	text = get_node("BasicEnemyText")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	update_collision_layer()

func update_collision_layer():
	if (text.is_focused):
		set_collision_layer_value(4, true)

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
	var basic_enemy_vector = (goal_position - starting_position) * speed
	var collision = move_and_collide(basic_enemy_vector * delta)
	if (collision != null && ship == collision.get_collider()):
		text.break_streak.emit()
		remove_word()
		damage_ship.emit()
