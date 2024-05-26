extends Label

var multiplier

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplier = 0
	text = str(multiplier)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func increment_multiplier():
	multiplier += 1
	text = str(multiplier)

func break_multiplier():
	multiplier = 0
	text = str(multiplier)
