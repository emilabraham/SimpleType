extends Node2D

signal game_over

var hearts = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hearts = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _remove_heart():
	var heart_to_remove = hearts.pop_back()
	heart_to_remove.queue_free()
	if hearts.is_empty():
		game_over.emit()
