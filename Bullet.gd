extends Sprite2D

signal destroy_word

var speed = 1000
var target_word = null
var starting_position = Vector2(600, 575)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _fire(word):
	target_word = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves toward the word, then deletes itself
func _process(delta):
	if (target_word):
		position = position.move_toward(target_word.position, delta * speed)
		if (position == target_word.position):
			target_word.remove_word()
			target_word = null
			destroy_word.emit()
			delete_bullet()

func delete_bullet():
	queue_free()
