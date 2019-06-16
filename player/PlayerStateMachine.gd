extends StateMachine

func _ready() -> void:
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"jump": $Jump,
		"fall": $Fall,
		"diving": $Diving
	}