extends Node2D

onready var initial_position = get_node("MainCamera").global_position

func _process(delta):
	if not $Player/AudioStreamPlayer2D.playing:
		$Player/AudioStreamPlayer2D.play()

func _on_Beginning_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, initial_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()
		$Player/AudioStreamPlayer2D2.play()

func _on_step1_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step2/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step2_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step3/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step3_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step4/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step4_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step5/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step5_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step6/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step6_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step7/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step7_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step8/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step8_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step9/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_step9_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "position", $MainCamera.global_position, $Steps/Step10/Camera.global_position, .5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()
		$CameraInterpolation.interpolate_property($MainCamera, "zoom", $MainCamera.zoom, $Steps/Step10/Camera.zoom, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()

func _on_zoomArea_body_entered(body):
	if body.is_in_group('player'):
		$CameraInterpolation.interpolate_property($MainCamera, "zoom", $MainCamera.zoom, Vector2(2, 2), 2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$CameraInterpolation.start()