extends Area2D
class_name ItemCarrier

var merge_stage: int
static var orbit_distance: float = 500

func update_merge_stage(merge_stage: int) -> void:
	self.merge_stage = merge_stage
	$Collision.shape.radius = MergeItemRegistry.det_radius(merge_stage)
	$Sprite.texture = MergeItemRegistry.det_texture(merge_stage)

func make_item() -> MergeItem:
	return MergeItemRegistry.create_merge_item(merge_stage, self.position)
	
func cycle_item(merge_stage: int) -> MergeItem:
	var new_item: MergeItem = make_item()
	self.update_merge_stage(merge_stage)
	return new_item

func check_collision(body: Node2D) -> void:
	if not is_instance_valid(body):
		return
	if not body is MergeItem:
		return
		
	var other := body as MergeItem
		
	if not self.is_inside_tree() or not other.is_inside_tree():
		return
	if not other.is_new:
		print("Game End Condition")
		# TODO

func update_position() -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var mouse_direction: Vector2 = (mouse_position - get_parent().global_position).normalized()
	if mouse_direction == Vector2.ZERO:
		return
	position = mouse_direction * orbit_distance

func _on_body_entered(body: Node2D) -> void:
	check_collision(body)

func _physics_process(delta: float) -> void:
	update_position()
