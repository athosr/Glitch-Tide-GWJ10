extends CanvasLayer

var dialog = [""]
var page = 0

signal finished

func _ready():
	$RichTextLabel.dialog = dialog

func _on_RichTextLabel_finished():
	emit_signal('finished')