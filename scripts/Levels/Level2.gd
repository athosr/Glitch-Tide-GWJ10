extends Node2D

var player = preload("res://scenes/Player/Player.tscn") as PackedScene
var fade = preload("res://scenes/Interface/Fade.tscn") as PackedScene
var dialog = preload("res://scenes/Interface/DialogBox.tscn") as PackedScene

var creature_attacking : bool = false
var d = dialog.instance()
var d2 = dialog.instance()

func _ready():
	$AnimationPlayer.play("creature_patrol")
	d.dialog = ["What?? Why I'm still in this place?", "Well, it looks a little different...", "I must find something to do here"]
	$CanvasLayer.add_child(d)
	d.connect("finished", self, 'dialog_finished')

func dialog_finished():
	d.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	$CanvasLayer.add_child(f)
	yield(f, "finished")
	$PlayerStart.add_child(player.instance())

func _on_Camera1_body_entered(body):
	if body.is_in_group('player'):
		$Camera1/Camera2D.current = true
		$CanvasModulate.color = Color(1, 1, 1, 1)
func _on_Camera2_body_entered(body):
	if body.is_in_group('player'):
		$Camera2/Camera2D.current = true
		$CanvasModulate.color = Color(0, 0, 0, 1)

func _on_Camera3_body_entered(body):
	if body.is_in_group('player'):
		$Camera3/Camera2D.current = true

func _on_teleport_left_body_entered(body):
	if body.is_in_group('player'):
		body.global_position = $WorldBorders/t_player_left.global_position
func _on_teleport_right_body_entered(body):
	if body.is_in_group('player'):
		body.global_position = $WorldBorders/t_player_right.global_position

func _on_LightsOn_body_entered(body):
	if body.is_in_group('player'):
		$CanvasModulate.color = Color(1, 1, 1, 1)
		creature_attacking = true

func _on_LightsOn_body_exited(body):
	if body.is_in_group('player'):
		creature_attacking = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if creature_attacking:
		$AnimationPlayer.play("creature_attack")
	else:
		$AnimationPlayer.play("creature_patrol")

func _on_Area2_body_entered(body):
	if body.is_in_group('player'):
		body.queue_free()
		$EventTriggers/Area2/Timer.start()

func _on_Timer_timeout():
	$EventTriggers/Area2.queue_free()
	$EventTriggers/Area2/Timer.queue_free()
	d2.dialog = ["This creature...", "WHY IS EVERYTHING SO WEIRD HERE??", "I must be careful"]
	$CanvasLayer.add_child(d2)
	d2.connect("finished", self, 'dialog2_finished')

func dialog2_finished():
	d2.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	$CanvasLayer.add_child(f)
	yield(f, "finished")
	$EventTriggers/Area2Position.add_child(player.instance())