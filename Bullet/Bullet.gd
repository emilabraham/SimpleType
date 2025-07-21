extends CharacterBody2D

var speed: float = 2.5
var target_enemy: CharacterBody2D = null
var starting_position: Vector2 = Vector2(300, 700)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _fire(enemy):
	target_enemy = enemy

# Called every frame. 'delta' is the elapsed time since the previous frame.
# Moves toward the enemy, then deletes itself and the enemy
func _process(delta):
	if (target_enemy):
		var bullet_vector = (target_enemy.position - starting_position) * speed
		var collision = move_and_collide(bullet_vector * delta)

		if collision == null:
			return

		if (target_enemy.text.text.length() == 0):
			remove_enemy(collision)
		else:
			damage_enemy(collision)

func damage_enemy(collision):
	if collision.get_collider() == target_enemy:
		delete_bullet()

func remove_enemy(collision):
	if collision.get_collider() == target_enemy:
		target_enemy.remove_word()
		target_enemy = null
		delete_bullet()

func delete_bullet():
	queue_free()
