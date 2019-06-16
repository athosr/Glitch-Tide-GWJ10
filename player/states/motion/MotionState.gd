# Collection of important methods to handle direction and animation
extends State
class_name MotionState

var direction_map = {
	"up": -1,
	"down": 1,
	"left": -1,
	"right": 1
}

var is_moving : bool
var is_jumping : bool
var is_moving_right : bool
var is_moving_left : bool
var is_idle : bool
var is_attacking : bool
var is_getting_down : bool

var speed = 0.0
var velocity : Vector2 = Vector2()

#func handle_input(event : InputEvent) -> void:
#	if event.is_action_pressed("simulate_damage"):
#		emit_signal("finished", "stagger")

func get_input_direction() -> Vector2:
	var input_direction : Vector2 = Vector2()
	input_direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input_direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	is_moving = true if input_direction.x == direction_map.right or input_direction.x == direction_map.left else false
	is_jumping = true if input_direction.y == direction_map.up else false
	is_moving_right = true if input_direction.x == direction_map.right else false
	is_moving_left = true if input_direction.x == direction_map.left else false
	is_idle = true if not input_direction else false
	is_attacking = true if Input.is_action_pressed("attack") else false
	is_getting_down = true if input_direction.y == direction_map.down else false

	return input_direction

func update_look_direction(direction : Vector2) -> void:
	if direction and owner.look_direction != direction:
		owner.look_direction = direction