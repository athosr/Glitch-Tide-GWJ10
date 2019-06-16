extends KinematicBody2D
class_name Entity

signal direction_changed(new_direction)

var look_direction : Vector2 = Vector2(1, 0) setget set_look_direction

func set_look_direction(value) -> void:
	look_direction = value
	emit_signal("direction_changed", value)