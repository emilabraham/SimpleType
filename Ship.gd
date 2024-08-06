extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_kill_word(_main, word):
	look_at(word.position)
	# An extra 90 degree rotation because for some reason "forward" is right
	rotate(PI/2)
