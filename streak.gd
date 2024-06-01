extends Label

signal multiplier_threshold_crossed

var streak
var streak_thresholds = [4, 8, 16, 32, 64]

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
	if streak_thresholds.has(streak):
		multiplier_threshold_crossed.emit()
	
func break_streak():
	streak = 0
	text = str(streak)
