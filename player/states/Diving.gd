extends MotionState

var fallMultiplier : float = 3
var lowJumpMultiplier : float = 5

var jump_count : int = 1
var can_jump : bool = false

# Initialize the state. E.g. change the animation
func enter() -> void:
	update_animation()

func handle_input(event : InputEvent) -> void:
	.handle_input(event)

func update(delta : float) -> void:
	var input_direction : Vector2 = get_input_direction()
	owner.friction = false

	if owner.is_on_floor():
		emit_signal("finished", "idle")


func update_animation():
	var animation : String = ''
	animation = "diving"

	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)