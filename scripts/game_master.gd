extends Control
class_name GameMaster

func add_points(points: int) -> void:
	$ScoreDisplay.add_points(points)

func cycle_merge_items() -> void:
	var merge_stage: int = $ItemQueue.pop_item()
	var new_item: MergeItem = $PlayArea.item_carrier.cycle_item(merge_stage)
	$PlayArea.add_child(new_item)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		cycle_merge_items()

func _ready() -> void:
	var merge_stage: int = $ItemQueue.pop_item()
	var new_item: MergeItem = $PlayArea.item_carrier.cycle_item(merge_stage)
