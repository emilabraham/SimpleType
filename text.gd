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
	# TODO: Bug here where we are always breaking the streak
	# TODO: I think we should check if it is focused text as the first thing
	if text.substr(0, 1).to_lower().contains(key_label):
		if should_focus(text):
			set_focus(true)
		if is_focused:
			update_text()
			update_score.emit()
	else:
		break_streak.emit()

func set_word(word):
	text = word
	original_text_length = text.length()

func should_focus(t):
	var is_first_character = t.length() == original_text_length
	var enemies = get_tree().get_nodes_in_group("enemies")
	var no_other_focus = true
	for enemy in enemies:
		if enemy.is_focused:
			no_other_focus = false
	return is_first_character && no_other_focus

func update_text():
	text = text.substr(1, text.length() + 1)
	if text.is_empty():
		set_focus(false)
		kill_word.emit()
		remove_from_group("enemies")
		queue_free()

func set_focus(value):
	is_focused = value
	if value:
		add_theme_color_override("font_color", "red")
	else:
		add_theme_color_override("font_color", "white")
