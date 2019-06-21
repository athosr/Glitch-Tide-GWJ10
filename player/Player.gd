extends Entity

export var GRAVITY : float
export var JUMP_HEIGHT : float
export var ACCELERATION : float
export var MAX_SPEED : float
export var FLOOR_LERP : float
export var AIR_LERP : float
export var MAX_JUMPS : int

var options_open : bool = false

var original_gravity : float

var motion : Vector2
var UP : Vector2 = Vector2(0, -1)
var friction : bool = true

var is_alive : bool = true

onready var collider = $CollisionShape2D
var collision_info : KinematicCollision2D

func _ready():
	self.add_to_group("player")
	set_arrow()

func _physics_process(delta) -> void:
	# Applies gravity and friction
	motion.y += GRAVITY

	if Input.is_action_just_pressed('escape'):
		options_menu()

	# Applies resistence
	if is_on_floor():
		if friction == true:
			motion.x = lerp(motion.x, 0.0, FLOOR_LERP)
	else:
		motion.x = lerp(motion.x, 0.0, AIR_LERP)

	# Rotates the body
	if motion.x > 0:
		$BodyPivot.scale.x = 1
	if motion.x < 0:
		$BodyPivot.scale.x = -1

	if motion.y >= 1400:
		motion.y = 1400

	motion = Vector2(round(motion.x), round(motion.y))
	motion = move_and_slide(motion, UP)

func options_menu():
	if options_open:
		$CanvasLayer/Options.visible = false
		options_open = false
	else:
		$CanvasLayer/Options.visible = true
		options_open = true

func set_arrow():
	$BodyPivot/PlayerArrow.visible = true
	$Effects.play('arrow')
	var timer = Timer.new()
	timer.wait_time = 5
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "end_arrow")
	original_gravity = GRAVITY
	$BodyPivot/BodyParameter.scale.x *= -1

func _on_Menu_pressed():
	get_tree().change_scene("res://scenes/Interface/Menu.tscn")
func _on_Exit_pressed():
	get_tree().quit()


func end_arrow():
	$BodyPivot/PlayerArrow.visible = false
	$Effects.stop()

