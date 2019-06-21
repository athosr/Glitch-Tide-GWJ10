extends MotionState

# Initialize the state. E.g. change the animation
func enter() -> void:
	pass

func handle_input(event : InputEvent) -> void:
	.handle_input(event)


func update(delta : float) -> void:
	update_animation()
	var input_direction : Vector2 = get_input_direction()
	owner.friction = false

	owner.motion.y = 600
	#owner.motion.y = lerp(owner.motion.y, 0.0, .1)
	if	owner.owner.name == 'Level3':
		if is_moving_right:
			owner.motion.x = min(owner.motion.x + owner.ACCELERATION, owner.MAX_SPEED)
		if is_moving_left:
			owner.motion.x = max(owner.motion.x - owner.ACCELERATION, -owner.MAX_SPEED)

func update_animation():
	var animation : String = ''
	animation = "diving"
	
	if owner.is_on_floor():
		animation = 'move'

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)