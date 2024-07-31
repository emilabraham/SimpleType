extends Node

var dictionary = []
var enemy1 = preload("res://Enemy1.tscn")
var bullet = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#load_dictionary()
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

func spawn_word():
	var enemy1_instance = enemy1.instantiate()
	add_child(enemy1_instance)
	enemy1_instance.text.update_score.connect($HUD._on_text_update_score)
	enemy1_instance.text.break_streak.connect($HUD._on_text_break_streak)
	enemy1_instance.text.kill_word.connect(_on_kill_word)
	enemy1_instance.text.kill_word.connect($Ship._on_kill_word)

func _on_kill_word(word):
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.destroy_word.connect(_on_destroy_word)
	bullet_instance._fire(word)

func _on_destroy_word():
	spawn_word()
