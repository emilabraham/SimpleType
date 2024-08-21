extends Node

var enemy1 = preload("res://Enemy1.tscn")
var bullet = preload("res://Bullet.tscn")
var time_start = 0
var time_now = 0
var time_index = 0
var map_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_unix_time_from_system()
	spawn_enemy1()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	calculate_elapsed_time()

func calculate_elapsed_time():
	time_now = Time.get_unix_time_from_system()
	var time_elapsed = round(time_now - time_start)
	if (time_elapsed > time_index):
		time_index = time_elapsed
		increment_map_index()

# increment the map index and then spawn the new enemy
func increment_map_index():
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
	bullet_instance.destroy_enemy.connect(_on_destroy_enemy)
	bullet_instance._fire(enemy)

func _on_destroy_enemy():
	spawn_enemy1()
	spawn_enemy1()
