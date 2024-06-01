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
	var multiplier = get_parent().get_node("Multiplier").get_multiplier()
	score += multiplier
	text = str(score)
