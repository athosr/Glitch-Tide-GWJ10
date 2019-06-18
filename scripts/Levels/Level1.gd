extends Node2D

var player = load("res://scenes/Player/Player.tscn")
var fade = load("res://scenes/Interface/Fade.tscn")
var dialog = load("res://scenes/Interface/DialogBox.tscn")

var d = dialog.instance()

func _ready():
	if PlayerVariables.deaths == 0:
		d.dialog = ['What the fuck is happening here?', "This doesn't makes any sense at all", 'Well, maybe just a little bit']
	else:
		d.dialog = ["Well, this isn't too obvious...", "          Try Again"]
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

func dialog_finished():
	d.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	$CanvasLayer.add_child(f)
	yield(f, "finished")
	var p = player.instance()
	$PlayerStart.add_child(p)