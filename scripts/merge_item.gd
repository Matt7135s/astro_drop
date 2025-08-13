extends RigidBody2D

class_name MergeItem

var merge_stage: int
var is_new: bool = true
var is_merging: bool = false

var newness_timer: float = 2

func initialize(merge_stage: int) -> void:
	self.merge_stage = merge_stage
	mass = MergeItemRegistry.det_mass(merge_stage)
	$Collision.shape = $Collision.shape.duplicate()
	$Collision.shape.radius = MergeItemRegistry.det_radius(merge_stage)
	$Sprite.texture = MergeItemRegistry.det_texture(merge_stage)

func merge(other: MergeItem) -> void:
	self.is_merging = true
	other.is_merging = true
	
	await get_tree().create_timer(0.01).timeout
	
	var new_merge_stage: int = merge_stage + 1

	var new_position: Vector2 = (self.position + other.position) / 2
	var new_linear_velocity: Vector2 = (self.linear_velocity + other.linear_velocity) / 2
	var new_angular_velocity: float = (self.angular_velocity + other.angular_velocity) / 2
	
	var new_item = MergeItemRegistry.create_merge_item(new_merge_stage, new_position, new_linear_velocity, new_angular_velocity)
	
	new_item.is_new = false
	
	get_parent().add_child(new_item)
	
	get_parent().get_parent().add_points(MergeItemRegistry.det_points(merge_stage))
	
	queue_free()
	other.queue_free()

func check_merge(body: Node2D) -> void:
	if not is_instance_valid(body):
		return
	if not body is MergeItem:
		return
		
	var other := body as MergeItem
		
	if not self.is_inside_tree() or not other.is_inside_tree():
		return
	if self.is_merging or other.is_merging:
		return
		
	if not other.is_new:
		self.is_new = false
		
	if not self.merge_stage == other.merge_stage:
		return
	if self.merge_stage >= 9:
		return
	if self.get_instance_id() < other.get_instance_id():
		merge(other)

func update_newness(delta: float) -> void:
	if self.is_new:
		newness_timer -= delta
		if newness_timer <= 0:
			is_new = false

func _on_body_entered(body: Node) -> void:
	check_merge(body)

func _physics_process(delta: float) -> void:
	update_newness(delta)
