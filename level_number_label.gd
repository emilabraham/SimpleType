extends Label

var level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_level(input_level) -> void:
	level = input_level
	text = str(level)
