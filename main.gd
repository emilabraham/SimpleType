extends Node

var enemy1 = preload("res://Enemy1.tscn")
var bullet = preload("res://Bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_word()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func spawn_word():
	var enemy1_instance = enemy1.instantiate()
	add_child(enemy1_instance)
	enemy1_instance.text.update_score.connect($HUD._on_text_update_score)
	enemy1_instance.text.break_streak.connect($HUD._on_text_break_streak)
	enemy1_instance.text.kill_word.connect(_on_kill_word.bind(enemy1_instance))
	enemy1_instance.text.kill_word.connect($Ship._on_kill_word.bind(enemy1_instance))

func _on_kill_word(_main, enemy):
	var bullet_instance = bullet.instantiate()
	add_child(bullet_instance)
	bullet_instance.destroy_enemy.connect(_on_destroy_enemy)
	bullet_instance._fire(enemy)

func _on_destroy_enemy():
	spawn_word()
