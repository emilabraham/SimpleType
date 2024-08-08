extends CharacterBody2D

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
	## TODO: I want the bullet to travel towards the target_enemy, then report when it collides
	if (target_enemy):
		#position = position.move_toward(target_enemy.position, speed)
		var collision = move_and_collide(position.move_toward(target_enemy.position, speed) * delta)
		
		#position = position.move_toward(target_enemy.position, delta * speed)
		if (collision != null):
			print(collision)
			print(collision.get_collider().name)
			
		if (position == target_enemy.position):
			target_enemy.remove_word()
			target_enemy = null
			destroy_enemy.emit()
			delete_bullet()

func delete_bullet():
	queue_free()
