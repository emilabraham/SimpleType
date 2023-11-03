extends Label

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	text = str(score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func increment_score():
	score += 1
	text = str(score)
