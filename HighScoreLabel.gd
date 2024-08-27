extends Label

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str("High Score: " + str(score))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func set_score(input_score):
	score = input_score
	text = str("High Score: " + str(score))
