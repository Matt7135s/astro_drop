extends Node2D
class_name GravityCenter

var strength: float = 1

func apply_gravity(item: MergeItem) -> void:
	var displacement: Vector2 = item.global_position - self.global_position
	var force: Vector2 = -displacement * strength * item.mass
	item.apply_central_force(force)

func _physics_process(delta: float) -> void:
	for item in get_tree().get_nodes_in_group("merge_items"):
		apply_gravity(item)
