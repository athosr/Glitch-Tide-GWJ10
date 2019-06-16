extends Node2D

var fade = preload("res://scenes/Interface/Fade.tscn")
var dialog = preload("res://scenes/Interface/DialogBox.tscn")
var d = dialog.instance()

func _ready():
	d.dialog = ['What the fuck is happening here?', "This doesn't makes any sense at all"]
	$CanvasLayer.add_child(d)
	d.connect("finished", self, 'dialog_finished')

func _on_Death_body_entered(body):
	if body.is_in_group('player'):
		PlayerVariables.deaths += 1
		var f = fade.instance()
		f.time = 1
		f.in_mode = true
		$CanvasLayer.add_child(f)
		yield(f, "finished")
		return get_tree().reload_current_scene()

func _on_Gate_body_entered(body):
	if body.is_in_group('player'):
		return get_tree().change_scene("res://scenes/Levels/Level2.tscn")

func dialog_finished():
	d.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	$CanvasLayer.add_child(f)
	yield(f, "finished")