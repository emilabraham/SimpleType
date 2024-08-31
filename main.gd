extends Node

var enemy1 = preload("res://Enemy1.tscn")
var bullet = preload("res://Bullet.tscn")
var game_data = {}
var time_start = 0
var time_now = 0
var time_index = 0
var map_index = -1
var level_index = 0
var waiting_for_screen_clear = false

const ENEMY_1 = '1'
const END_LEVEL = 'E'

# Called when the node enters the scene tree for the first time.
func _ready():
	load_game_data()
	load_next_level()
	time_start = Time.get_unix_time_from_system()
	$HUD.emit_highest_score.connect($GameOver._on_update_highest_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (!waiting_for_screen_clear):
		pass_time()
	else:
		check_to_load_next_level()

func load_game_data():
	var filename = "res://game_data.txt"
	var file = FileAccess.open(filename, FileAccess.READ)
	for i in file.get_as_text().count(":"):
		var line = file.get_line()
		if line.contains(":"):
			var value = line.split(":")[1]
			value = value.trim_prefix("[")
			value = value.trim_suffix("],")
			value = value.replace("\"", "")
			value = value.split(",")
			game_data[level_index] = value
			level_index = level_index + 1
	file.close()
	level_index = -1

func check_to_load_next_level():
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		load_next_level()
		waiting_for_screen_clear = false

func load_next_level():
	level_index = level_index + 1
	map = game_data[level_index]
	time_start = Time.get_unix_time_from_system()
	time_index = 0
	map_index = -1

# Keep the in-game time updated
func pass_time():
	time_now = Time.get_unix_time_from_system()
	var time_elapsed = round(time_now - time_start)
	if (time_elapsed > time_index):
		time_index = time_elapsed
		increment_map_index()

# increment the map index and then spawn the new enemy
func increment_map_index():
	map_index = map_index + 1
	if (map_index < map.size()):
		var current_spawn = map[map_index]
		choose_spawn(current_spawn)

func choose_spawn(current_spawn):
	match current_spawn:
		ENEMY_1:
			spawn_enemy1()
		END_LEVEL:
			waiting_for_screen_clear = true
		_:
			pass

func spawn_enemy1():
	var enemy1_instance = enemy1.instantiate()
	add_child(enemy1_instance)
	enemy1_instance.text.update_score.connect($HUD._on_text_update_score)
	enemy1_instance.text.break_streak.connect($HUD._on_text_break_streak)
	enemy1_instance.text.kill_word.connect(_on_kill_word.bind(enemy1_instance))
	enemy1_instance.text.kill_word.connect($Ship._on_kill_word.bind(enemy1_instance))
	enemy1_instance.ship = $Ship
	enemy1_instance.damage_ship.connect($Ship._on_damage_ship)

func _on_kill_word(_main, enemy):
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance._fire(enemy)


func _on_healthbar_game_over():
	for child in get_children():
		if child.name != "GameOver":
			child.queue_free()
	$GameOver.visible = true
