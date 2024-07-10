extends Node

var dictionary = []
var text = preload("res://text.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	load_dictionary()
	spawn_word()
	spawn_word()

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
	
func _on_kill_word():
	spawn_word()

func spawn_word():
	var text_instance = text.instantiate()
	text_instance.set_position(Vector2(randi_range(100, 1000), randi_range(100, 500)))
	text_instance.set_word(dictionary.pick_random())
	add_child(text_instance)
	text_instance.update_score.connect($HUD._on_text_update_score)
	text_instance.break_streak.connect($HUD._on_text_break_streak)
	text_instance.kill_word.connect(_on_kill_word)
