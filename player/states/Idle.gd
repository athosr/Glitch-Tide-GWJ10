extends MotionState

# Initialize the state. E.g. change the animation
func enter() -> void:	
	return


# Clean up the state. Reinitialize values like a timer
func exit() -> void:
	return


func handle_input(event : InputEvent) -> void:
	.handle_input(event)


func update(delta : float) -> void:
	update_animation(owner.look_direction)
	var input_direction : Vector2 = get_input_direction()
	owner.friction = true

	if is_moving:
		emit_signal("finished", "move")
	if is_jumping and owner.is_on_floor():
		emit_signal("finished", "jump")
	if is_attacking:
		emit_signal("finished", "attack")
	if is_getting_down:
		emit_signal("finished", "fall")

	# Rounding frictioned motion
	if owner.get_node("BodyPivot").scale.x == 1 and owner.motion.x < owner.ACCELERATION*2:
		owner.motion.x = 0.0
	if owner.get_node("BodyPivot").scale.x == -1 and owner.motion.x > -owner.ACCELERATION*2:
		owner.motion.x = 0.0

func update_animation(motion: Vector2) -> void:
	var animation : String = ''

	if owner.motion.x:
		animation = "sliding"
	else:
		animation = "idle"

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)