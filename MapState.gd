extends Node

signal emit_spawn
signal new_level

var game_data: Dictionary = {}
var level_index: int = 0
var map_index: int = -1
var map: Array
var waiting_for_screen_clear: bool = false
var time_start: float = 0
var time_now: float = 0
var time_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (!waiting_for_screen_clear):
		pass_time()
	else:
		check_to_load_next_level()

func pass_time():
	time_now = Time.get_unix_time_from_system()
	var time_elapsed = round(time_now - time_start)
	if (time_elapsed > time_index):
		time_index = time_elapsed
		increment_map_index()

func check_to_load_next_level():
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		load_next_level()
		waiting_for_screen_clear = false

func load_next_level():
	get_next_level()
	time_start = Time.get_unix_time_from_system()
	time_index = 0

func load_game_data():
	var filename = "res://resources/game_data.txt"
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
	
func get_next_level():
	level_index = level_index + 1
	map = game_data[level_index]
	new_level.emit(level_index)
	map_index = -1

# increment the map index and then spawn the new enemy
func increment_map_index():
	var current_spawn = null
	map_index = map_index + 1
	if (map_index < map.size()):
		current_spawn = map[map_index]
	emit_spawn.emit(current_spawn)
