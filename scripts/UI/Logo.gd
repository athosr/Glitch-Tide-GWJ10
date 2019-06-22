extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	play()

func _on_Logo_frame_changed():
	if frame == 0 or frame == 16:
		stop()
		$Timer.start()

func _on_Timer_timeout():
	play()