extends MotionState

func enter() -> void:
	speed = 0.0

	var input_direction : Vector2 = get_input_direction()
	update_look_direction(input_direction)
	update_animation(input_direction)

func handle_input(event : InputEvent) -> void:
	.handle_input(event)


func update(delta : float) -> void:
	var input_direction : Vector2 = get_input_direction()
	update_look_direction(input_direction)
	owner.friction = true

	if is_jumping and owner.is_on_floor():
		emit_signal("finished", "jump")
	if is_idle:
		emit_signal("finished", "idle")
	if is_attacking:
		emit_signal("finished", "attack")
	if is_getting_down:
		emit_signal("finished", "fall")

	if is_moving_right:
		owner.motion.x = min(owner.motion.x + owner.ACCELERATION, owner.MAX_SPEED)
	if is_moving_left:
		owner.motion.x = max(owner.motion.x - owner.ACCELERATION, -owner.MAX_SPEED)


func update_animation(motion: Vector2) -> void:
	var animation : String = ''

	animation = "move"
	
	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)