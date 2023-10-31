extends Label

signal update_score
signal break_streak

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "emilabraham"

func _input(event):
	if event is InputEventKey:
		contains_and_emit(event.as_text_key_label().to_lower())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func contains_and_emit(key_label):
	if text.substr(0, 1).contains(key_label):
		update_text()
		update_score.emit()
	else:
		break_streak.emit()

func update_text():
	text = text.substr(1, text.length() + 1)
	if text.is_empty():
		hide()
