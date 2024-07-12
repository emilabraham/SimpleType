extends Label

signal update_score
signal break_streak
signal kill_word

var dictionary = []
var is_focused = false
var original_text = ""

func _ready():
	add_to_group("enemies")

func _input(event):
	if event is InputEventKey and event.is_pressed():
		contains_and_emit(event.as_text_key_label().to_lower())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func contains_and_emit(key_label):
	# TODO: Bug where we are not breaking the streak when there is no focused enemy
	var is_first_character = text.substr(0, 1).to_lower().contains(key_label)
	if has_focused_enemy():
		if is_focused:
			if is_first_character:
				update_text()
				update_score.emit()
			else:
				break_streak.emit()
	else:
		if should_focus(text, is_first_character):
			set_focus(true)
			update_text()
			update_score.emit()

func set_word(word):
	text = word
	original_text = word

func should_focus(t, is_first_character):
	var fresh_word = t == original_text
	return fresh_word && is_first_character && !has_focused_enemy()

func has_focused_enemy():
	var enemies = get_tree().get_nodes_in_group("enemies")
	var no_other_focus = false
	for enemy in enemies:
		if enemy.is_focused:
			no_other_focus = true
	return no_other_focus

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
