extends Control
class_name ScoreDisplay

var score: int = 0

func add_points(points: int) -> void:
	score += points
	$Margin/VSplit/ScoreValue.text = str(score)
