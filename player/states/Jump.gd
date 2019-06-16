extends MotionState

var fallMultiplier : float = 3
var lowJumpMultiplier : float = 5

var jump_count : int = 1
var can_jump : bool = false
var is_new_anim : bool = true

# Initialize the state. E.g. change the animation
func enter() -> void:
	velocity = Vector2()
	update_animation()
	if owner.is_on_floor():
		apply_jump_force()
	return

func handle_input(event : InputEvent) -> void:
	.handle_input(event)
	if Input.is_action_just_pressed("ui_up") and jump_count < owner.MAX_JUMPS:
		owner.GRAVITY = owner.original_gravity
		jump_count += 1
		apply_jump_force()
		update_animation()

func update(delta : float) -> void:
	var input_direction : Vector2 = get_input_direction()
	owner.friction = false

	# Changing the value of the player's gravity to jump more or less, and accelerating the falling
	if owner.motion.y > 0:
		owner.GRAVITY = owner.original_gravity * fallMultiplier
	elif owner.motion.y < 0 and not Input.is_action_pressed("ui_up"):
		owner.GRAVITY = owner.original_gravity * lowJumpMultiplier

	if owner.is_on_floor():
		if is_moving:
			emit_signal("finished", "move")
		if is_idle:
			emit_signal("finished", "idle")
		if is_getting_down:
			emit_signal("finished", "fall")

	if is_moving_right:
		owner.motion.x = min(owner.motion.x + owner.ACCELERATION, owner.MAX_SPEED)
	if is_moving_left:
		owner.motion.x = max(owner.motion.x - owner.ACCELERATION, -owner.MAX_SPEED)

func apply_jump_force():
	owner.motion.y = owner.JUMP_HEIGHT
	can_jump = true

func update_animation():
	var animation : String = ''
	if is_new_anim == null:
		animation = 'jump'
		is_new_anim = true
	else:
		animation = 'fall'

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)

func exit() -> void:
	owner.GRAVITY = owner.original_gravity
	jump_count = 1
	return