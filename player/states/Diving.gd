extends MotionState

var fallMultiplier : float = 3
var lowJumpMultiplier : float = 5

var jump_count : int = 1
var can_jump : bool = false

# Initialize the state. E.g. change the animation
func enter() -> void:
	owner.motion.y = 0.0
	update_animation()

func handle_input(event : InputEvent) -> void:
	.handle_input(event)

func update(delta : float) -> void:
	owner.GRAVITY = 0.0
	var input_direction : Vector2 = get_input_direction()
	owner.friction = false

	if owner.is_on_floor():
		emit_signal("finished", "idle")

	if is_moving_right:
		owner.motion.x = min(owner.motion.x + owner.ACCELERATION, owner.MAX_SPEED)
	if is_moving_left:
		owner.motion.x = max(owner.motion.x - owner.ACCELERATION, -owner.MAX_SPEED)
	if is_jumping:
		owner.motion.y = max(owner.motion.y - owner.ACCELERATION/2, -owner.MAX_SPEED/2)
	if is_getting_down:
		owner.motion.y = min(owner.motion.y + owner.ACCELERATION/2, owner.MAX_SPEED/2)

	#owner.motion.y = lerp(owner.motion.y, 0.0, .1)

func update_animation():
	var animation : String = ''
	animation = "diving"

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)