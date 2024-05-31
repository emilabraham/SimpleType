extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$Streak.multiplier_threshold_crossed.connect(_on_multiplier_threshold_crossed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_text_update_score():
	$Score.increment_score()
	$Streak.increment_streak()

func _on_text_break_streak():
	$Streak.break_streak()
	
func _on_multiplier_threshold_crossed():
	$Multiplier.increment_multiplier()
