extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_update_level(level):
	$LevelNumberLabel.set_level(level)
	visible = true
	await get_tree().create_timer(3).timeout
	visible = false
