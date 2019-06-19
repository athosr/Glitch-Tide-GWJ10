extends Control

var fade = preload("res://scenes/Interface/Fade.tscn")

var finished : bool = false

func _unhandled_input(event):
	var f = fade.instance()
	f.time = 1
	f.in_mode = true
	add_child(f)
	yield(f, "finished")
	return get_tree().change_scene("res://scenes/Menu/Menu.tscn")

func _ready():
	$AnimationPlayer.play("light")
	$AnimatedSprite.play('pt1')

func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play('pt2')
	finished = true
	$Label.visible = true
	$Node2D/Pt2.play()