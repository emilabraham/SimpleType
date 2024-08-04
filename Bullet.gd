extends Sprite2D

signal destroy_enemy

var speed = 1000
var target_enemy = null
var starting_position = Vector2(600, 575)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _fire(word):
	target_enemy = word

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves toward the word, then deletes itself
func _process(delta):
	if (target_enemy):
		position = position.move_toward(target_enemy.position, delta * speed)
		if (position == target_enemy.position):
			target_enemy.remove_word()
			target_enemy = null
			destroy_enemy.emit()
			delete_bullet()

func delete_bullet():
	queue_free()
