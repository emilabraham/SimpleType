extends Label

var streak

# Called when the node enters the scene tree for the first time.
func _ready():
	streak = 0
	text = str(streak)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func increment_streak():
	streak += 1
	text = str(streak)
	
func break_streak():
	streak = 0
	text = str(streak)
