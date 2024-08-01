extends Label

signal update_score
signal break_streak
signal kill_word(word)

var dictionary = []
var is_focused = false
var original_text = ""
var deleting = false

func _ready():
	pass

func _input(event):
	if event is InputEventKey and event.is_pressed():
		contains_and_emit(event.as_text_key_label().to_lower())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func contains_and_emit(key_label):
	var is_first_character = text.substr(0, 1).to_lower().contains(key_label)
	if has_focused_enemy():
		if is_focused:
			if is_first_character:
				update_text()
				update_score.emit()
			else:
				break_streak.emit()
	else:
		if should_focus(text, is_first_character) && !is_focused:
			if deleting:
				get_tree().call_group("enemies", "toggle_deleting")
			set_focus(true)
			update_text()
			update_score.emit()
		elif !can_focus(key_label) && !deleting:
			break_streak.emit()

func set_word(word):
	text = word
	original_text = word

# Determines if this word should get newly focused
func should_focus(t, is_first_character):
	var fresh_word = t == original_text
	return fresh_word && is_first_character && !has_focused_enemy()

# Determines if there is an enemy that already has focus
func has_focused_enemy():
	#var enemies = get_tree().get_nodes_in_group("enemies")
	#var no_other_focus = false
	#for enemy in enemies:
		#if enemy.is_focused:
			#no_other_focus = true
	#return no_other_focus
	pass

# Determines if the given letter is the first character in any of the enemies
func can_focus(key_label):
	#var enemies = get_tree().get_nodes_in_group("enemies")
	#var potential_focus = false
	#for enemy in enemies:
		#if enemy.text.substr(0, 1).to_lower().contains(key_label):
			#potential_focus = true
	#return potential_focus
	pass

# Update the text.
# Kills the text object if it is the last character.
func update_text():
	#if text.length() == 1:
		#kill_word.emit(self)
		#set_focus(false)
	#else:
		#text = text.substr(1, text.length() + 1)
	pass

func remove_word():
	#remove_from_group("enemies")
	#queue_free()
	#get_tree().call_group("enemies", "toggle_deleting")
	pass

# We enter deleting mode as we are deleting a text object
# We exit deleting mode as we are getting a new focus
# I noticed when entering the last character, we would inadverdently break the streak
# This method prevents that
func toggle_deleting():
	deleting = !deleting

func set_focus(value):
	is_focused = value
	if value:
		add_theme_color_override("font_color", "red")
	else:
		add_theme_color_override("font_color", "white")

func load_dictionary():
	var file = FileAccess.open('res://dictionary.txt', FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line()
		if (!line.is_empty()):
			dictionary.push_back(String(line))
	file.close()

# picks a word such that the first letter of all words is unique
func pick_word():
	var word = dictionary.pick_random()
	return word
	#var enemies = get_tree().get_nodes_in_group("enemies")
	#var non_unique = false
	#for enemy in enemies:
		#if enemy.text.substr(0, 1) == word.substr(0,1):
			#non_unique = true

	#if non_unique:
		#return pick_word()
	#else:
		#return word
