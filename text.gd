extends Label

signal update_score
signal break_streak

var dictionary = []

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dictionary()
	text = dictionary.pick_random()
	print(text)
	print(text.length())

func _input(event):
	if event is InputEventKey and event.is_pressed():
		contains_and_emit(event.as_text_key_label().to_lower())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func load_dictionary():
	var file = FileAccess.open('res://dictionary.txt', FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		if (!line.is_empty()):
			dictionary.push_back(String(line))
	file.close()

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
