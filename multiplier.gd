extends Label

var multiplier_index
var multiplier_values = [1, 2, 4, 8, 16, 32]

# Called when the node enters the scene tree for the first time.
func _ready():
	multiplier_index = 0
	text = str(multiplier_values[multiplier_index])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func increment_multiplier_index():
	if multiplier_index < multiplier_values.size():
		multiplier_index += 1
		text = str(multiplier_values[multiplier_index])

func break_multiplier():
	multiplier_index = 0
	text = str(multiplier_values[multiplier_index])
