extends CanvasLayer

var highest_score = 0

signal emit_highest_score

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
	update_highest_score()
	$Streak.break_streak()
	$Multiplier.break_multiplier()

func update_highest_score():
	if (highest_score < $Score.score):
		highest_score = $Score.score
		emit_highest_score.emit(highest_score)

func _on_multiplier_threshold_crossed():
	$Multiplier.increment_multiplier_index()
