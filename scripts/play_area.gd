extends Control
class_name PlayArea

var item_carrier: Area2D #Reference

func _ready() -> void:
	item_carrier = $ItemCarrier
