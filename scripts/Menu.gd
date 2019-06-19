extends Control

var first_time : bool = true

var dialog = preload("res://scenes/Interface/DialogBox.tscn")
var fade = preload("res://scenes/Interface/Fade.tscn")

var d = dialog.instance()
var d2 = dialog.instance()
var d3 = dialog.instance()

var t = Timer.new()

func _ready():
	if first_time:
		$CreditsScreen/AnimationPlayer.play('credits')
		t.wait_time = 1
		add_child(t)
		t.start()
		t.connect('timeout', self, 'start_tutorial')

func _on_Button_pressed():
	first_time = false
	return get_tree().change_scene("res://scenes/Levels/Level1.tscn")

func start_tutorial():
	t.queue_free()
	d.dialog = ["                Press spacebar to continue", "                           Hey!", "              You're welcome!", "What about to get used to the controls before the actual game?"]
	add_child(d)
	$Controls.visible = true
	d.connect("finished", self, 'dialog_finished')
func dialog_finished():
	d.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	add_child(f) 
	yield(f, "finished")

func _on_Tutorial_body_entered(body):
	if body.is_in_group('player'):
		d2.dialog = ["          What are you doing in here?", "         You can't do that!", "          Whatever... This game is simply broken."]
		add_child(d2)
		d2.connect("finished", self, 'dialog2_finished')
func dialog2_finished():
	d2.queue_free()
	$EventTrigger/Tutorial.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	add_child(f) 
	yield(f, "finished")

func _on_End_body_entered(body):
	if body.is_in_group('player'):
		d3.dialog = ["                And there you go...", "         Just click the 'play' button, lol"]
		add_child(d3)
		d3.connect("finished", self, 'dialog3_finished')

func dialog3_finished():
	d3.queue_free()
	$EventTrigger/End.queue_free()
	var f = fade.instance()
	f.time = 2
	f.in_mode = false
	add_child(f) 
	yield(f, "finished")


func _on_Credits_button_down():
	$CreditsScreen.visible = true
func _on_Credits_button_up():
	$CreditsScreen.visible = false
