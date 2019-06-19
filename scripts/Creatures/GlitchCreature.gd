extends KinematicBody2D

func _on_AnimatedSprite_frame_changed():
	if $AnimatedSprite.frame == 0:
		$AudioHandler/WingFlap.play()