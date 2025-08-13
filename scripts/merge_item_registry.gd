extends Node

class_name MergeItemRegistry

static var merge_item_scene := preload("res://scenes/merge_item.tscn")

static var mass_0: float = 1
static var mass_multiplier: float = 2

static var radius_0: float = 10
static var radius_multiplier: float = sqrt(2)

static var points_0: int = 1
static var points_multiplier: int = 2

static func det_mass(merge_stage: int) -> float:
	return mass_0 * pow(mass_multiplier, merge_stage)

static func det_radius(merge_stage: int) -> float:
	return radius_0 * pow(radius_multiplier, merge_stage)

static func det_texture(merge_stage: int):
	return MergeItemRegistry.icon[merge_stage]

static func det_points(merge_stage: int):
	return points_0 * pow(points_multiplier, merge_stage)

static var icon := [
	preload("res://icons/00.png"),
	preload("res://icons/01.png"),
	preload("res://icons/02.png"),
	preload("res://icons/03.png"),
	preload("res://icons/04.png"),
	preload("res://icons/05.png"),
	preload("res://icons/06.png"),
	preload("res://icons/07.png"),
	preload("res://icons/08.png"),
	preload("res://icons/09.png"),
]

static func create_merge_item(merge_stage: int, position: Vector2, linear_velocity: Vector2 = Vector2.ZERO, angular_velocity: float = 0) -> MergeItem:
	var new_item = merge_item_scene.instantiate() as MergeItem
	new_item.position = position
	new_item.linear_velocity = linear_velocity
	new_item.angular_velocity = angular_velocity
	new_item.initialize(merge_stage)
	return new_item
