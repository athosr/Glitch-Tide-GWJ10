extends Node2D

export var new_scene : String
export var color : Color

func _ready():
	$AnimationPlayer.play("light")
	$Light2D.color = color

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		get_tree().change_scene(new_scene)