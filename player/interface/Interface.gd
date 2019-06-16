extends Control

func _process(delta):
	$state/label.text = owner.get_node("StateMachine").current_state.name
	$location/label.text = str(Vector2(round(owner.motion.x), round(owner.motion.y)))