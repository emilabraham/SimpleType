extends Node

var game_data = {}
var level_index = 0
var map_index = -1
var map

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

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
	
func get_next_level():
	level_index = level_index + 1
	return game_data[level_index]
