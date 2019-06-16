extends Control

export var in_mode : bool
export var time : int

var tween = Tween.new()

signal finished

func _ready():
	if in_mode:
		add_child(tween)
		tween.interpolate_property($TextureProgress, 'value', 0, 100, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	else:
		add_child(tween)
		tween.interpolate_property($TextureProgress, 'value', 150, 0, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

	tween.connect("tween_completed", self, 'finished')

func finished(object, pathkey):
	emit_signal("finished")
	queue_free()