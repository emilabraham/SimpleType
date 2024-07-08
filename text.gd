extends Label

signal update_score
signal break_streak
signal kill_word

var dictionary = []
var is_focused = false
var original_text_length = 0

func _ready():
	add_to_group("enemies")

func _input(event):
	if event is InputEventKey and event.is_pressed():
		contains_and_emit(event.as_text_key_label().to_lower())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func contains_and_emit(key_label):
	if text.substr(0, 1).to_lower().contains(key_label):
		update_text()
		update_score.emit()
	else:
		break_streak.emit()

func set_word(word):
	text = word

func update_text():
	text = text.substr(1, text.length() + 1)
	if text.is_empty():
		kill_word.emit()
		remove_from_group("enemies")
		queue_free()
