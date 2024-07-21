extends Sprite2D

signal destroy_word

var speed = 1000
var target_position = position
var target_word = null

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _fire(word):
	visible = true
	target_word = word
	target_position = word.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (visible):
		position = position.move_toward(target_position, delta * speed)
		if (position == target_position):
			visible = false
			target_word.remove_word()
			target_word = null
