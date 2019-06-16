extends RichTextLabel

export var dialog = ["this is certainly a bug"]
var page = 0

signal finished

func _ready():
	set_bbcode(dialog[page])
	visible_characters = 0

func _process(delta):
	owner.page = page
	set_bbcode(dialog[page])
	if Input.is_action_just_pressed("ui_accept"):
		if page+1 == dialog.size():
			emit_signal('finished')
		else:
			page += 1
			set_bbcode(dialog[page])
			visible_characters = 0

func _on_Timer_timeout():
	visible_characters += 1