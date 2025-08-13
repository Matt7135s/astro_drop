extends Control
class_name ItemQueue

var merge_stage: int

static var merge_stage_max: int = 4

func update_image(merge_stage: int) -> void:
	$Margin/Sprite.texture = MergeItemRegistry.det_texture(merge_stage)

func prepare_item() -> void:
	merge_stage = randi_range(0, merge_stage_max)
	update_image(merge_stage)

func pop_item() -> int:
	var merge_stage_to_pop = merge_stage
	prepare_item()
	return merge_stage_to_pop

func _ready() -> void:
	prepare_item()
