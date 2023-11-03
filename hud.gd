extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_text_update_score():
	$Score.increment_score()
	$Streak.increment_streak()


func _on_text_break_streak():
	$Streak.break_streak()
