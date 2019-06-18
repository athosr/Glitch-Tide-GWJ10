extends Entity

export var GRAVITY : float
export var JUMP_HEIGHT : float
export var ACCELERATION : float
export var MAX_SPEED : float
export var FLOOR_LERP : float
export var AIR_LERP : float
export var MAX_JUMPS : int

var original_gravity : float

var motion : Vector2
var UP : Vector2 = Vector2(0, -1)
var friction : bool = true

var is_alive : bool = true

onready var collider = $CollisionShape2D

var collision_info : KinematicCollision2D

func _ready():
	$BodyPivot/PlayerArrow.visible = true
	$Effects.play('arrow')
	var timer = Timer.new()
	timer.wait_time = 5
	add_child(timer)
	timer.start()
	timer.connect("timeout", self, "end_arrow")
	original_gravity = GRAVITY
	$BodyPivot/BodyParameter.scale.x *= -1
	self.add_to_group("player")

func _physics_process(delta) -> void:
	# Applies gravity and friction
	motion.y += GRAVITY

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

func end_arrow():
	$BodyPivot/PlayerArrow.visible = false
	$Effects.stop()