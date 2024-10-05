extends Node

var enemy1: PackedScene = preload("res://Enemy1.tscn")
var bullet: PackedScene = preload("res://Bullet.tscn")
var waiting_for_screen_clear: bool = false

const ENEMY_1 = '1'
const END_LEVEL = 'E'

# Called when the node enters the scene tree for the first time.
func _ready():
	$MapState.load_game_data()
	$MapState.get_next_level()
	$HUD.emit_highest_score.connect($GameOver._on_update_highest_score)
	$MapState.new_level.connect($LevelScreen._on_update_level)
	$MapState.new_level.emit(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func choose_spawn(current_spawn):
	match current_spawn:
		ENEMY_1:
			spawn_enemy1()
		END_LEVEL:
			$MapState.waiting_for_screen_clear = true
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


func _on_map_state_emit_spawn(emitted_spawn):
	if (emitted_spawn != null):
		choose_spawn(emitted_spawn)
