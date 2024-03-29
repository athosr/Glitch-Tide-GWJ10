extends MotionState

var fallMultiplier : float = 3
var lowJumpMultiplier : float = 5

var jump_count : int = 1
var can_jump : bool = false

# Initialize the state. E.g. change the animation
func enter() -> void:
	disable_collider()
	update_animation()

func handle_input(event : InputEvent) -> void:
	.handle_input(event)

func update(delta : float) -> void:
	var input_direction : Vector2 = get_input_direction()
	owner.friction = false

	if owner.is_on_floor():
		emit_signal("finished", "idle")

	if is_moving_right:
		owner.motion.x = min(owner.motion.x + owner.ACCELERATION, owner.MAX_SPEED)
	if is_moving_left:
		owner.motion.x = max(owner.motion.x - owner.ACCELERATION, -owner.MAX_SPEED)

func disable_collider():
	owner.collider.disabled = true
	$Timer.start()

func update_animation():
	var animation : String = ''
	animation = "fall"

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)


func _on_Timer_timeout():
	owner.collider.disabled = false