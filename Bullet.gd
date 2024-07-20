extends Sprite2D

var speed = 800
var target = position

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _fire(word_position):
	visible = true
	target = word_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(visible):
		position = position.move_toward(target, delta * speed)
		if(position == target):
			visible = false
