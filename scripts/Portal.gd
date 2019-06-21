extends Node2D

export var next_level : String = 'Scene Path'

func _ready():
	$AnimationPlayer.play("light")

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		PlayerVariables.deaths = 0
		PlayerVariables.current_scene = 'Level3'
		return get_tree().change_scene(next_level)