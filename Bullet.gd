extends Sprite2D

signal destroy_word

var speed = 1000
var target_position = position
var target_word = null
var starting_position = Vector2(600, 575)
# TODO: Remove visible stuff. We are spawning it instead.
# TODO: Delete the bullet on hit
# TODO: Remove all the print statements

# Called when the node enters the scene tree for the first time.
func _ready():
	print("should be ready")
	visible = false

func _fire(word):
	visible = true
	print(word.position)
	target_word = word
	target_position = word.position
	print(target_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print("Should process")
	if (visible):
		position = position.move_toward(target_position, delta * speed)
		if (position == target_position):
			visible = false
			target_word.remove_word()
			target_word = null
			reset_position()
			destroy_word.emit()

func reset_position():
	position = starting_position
