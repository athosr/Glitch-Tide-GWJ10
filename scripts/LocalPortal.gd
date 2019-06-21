extends Node2D

export var new_location : NodePath
export var color : Color

func _ready():
	$AnimationPlayer.play("light")
	$Light2D.color = color

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		body.global_position = get_node(new_location).global_position