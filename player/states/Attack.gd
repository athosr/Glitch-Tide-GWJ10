extends MotionState

#const BASIC_SPELL = preload("res://scenes/Spells/BasicSpell.tscn")
#const SPELL1 = preload("res://scenes/Spells/Spell1.tscn")

# Initialize the state. E.g. change the animation
func enter() -> void:
	update_animation()


# Clean up the state. Reinitialize values like a timer
func exit() -> void:
	return


func handle_input(event : InputEvent) -> void:
	.handle_input(event)


func update(delta : float) -> void:
	owner.friction = true
	var input_direction : Vector2 = get_input_direction()
	update_look_direction(input_direction)

	# Rounding frictioned motion
	if owner.get_node("BodyPivot").scale.x == 1 and owner.motion.x < owner.ACCELERATION:
		owner.motion.x = 0
	if owner.get_node("BodyPivot").scale.x == -1 and owner.motion.x > -owner.ACCELERATION:
		owner.motion.x = 0

	if owner.get_node("AnimationPlayer").is_playing() == false:
		if is_jumping and owner.is_on_floor():
			emit_signal("finished", "jump")
		if is_idle:
			emit_signal("finished", "idle")
		if is_moving:
			emit_signal("finished", "move")


func update_animation() -> void:
	var animation : String = ''
	owner.get_node("BodyPivot/BodyParameter/body/hand_right/Position2D/Particles2D").emitting = true
	animation = "casting"
	
	if animation == '':
		return

	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	if animation_player.current_animation != animation:
		animation_player.play(animation)


func _on_Manabar_basic_spell():
	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	var animation : String = "basic_attack"

	if animation_player.current_animation != animation:
		animation_player.play(animation)

	yield(animation_player, "animation_finished")
	var new_spell := BASIC_SPELL.instance()
	new_spell.initialize(owner.get_node("BodyPivot/BodyParameter/body/hand_right/Position2D").global_position, owner.get_node("BodyPivot").scale.x)
	owner.owner.add_child(new_spell)


func _on_Manabar_spell1():
	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	var animation : String = "spell1"

	animation_player.play(animation)

	var new_spell := SPELL1.instance()
	new_spell.initialize(owner.global_position, owner.get_node("BodyPivot").scale.x)
	owner.owner.add_child(new_spell)

	yield(animation_player, "animation_finished")
	new_spell.transition()

	animation = "basic_attack"
	animation_player.play(animation)

	yield(animation_player, "animation_finished")
	var new_spell2 := BASIC_SPELL.instance()
	new_spell2.initialize(owner.get_node("BodyPivot/BodyParameter/body/hand_right/Position2D").global_position, owner.get_node("BodyPivot").scale.x)
	new_spell2.scale *= Vector2(3, 3)
	owner.owner.add_child(new_spell2)

func _on_Manabar_spell2():
	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	var animation : String = "spell2"

	animation_player.play(animation)

	var new_spell := SPELL1.instance()
	new_spell.initialize(owner.global_position, owner.get_node("BodyPivot").scale.x)
	owner.owner.add_child(new_spell)

	yield(animation_player, "animation_finished")
	new_spell.transition()

	animation = "basic_attack"
	animation_player.play(animation)

	yield(animation_player, "animation_finished")
	var new_spell2 := BASIC_SPELL.instance()
	new_spell2.initialize(owner.get_node("BodyPivot/BodyParameter/body/hand_right/Position2D").global_position, owner.get_node("BodyPivot").scale.x)
	new_spell2.scale *= Vector2(3, 3)
	owner.owner.add_child(new_spell2)


func _on_Manabar_spell3():
	var animation_player : AnimationPlayer = owner.get_node("AnimationPlayer")
	animation_player.stop(true)
	print("spell 3 casted")


func _on_Manabar_finished():
	owner.get_node("BodyPivot/BodyParameter/body/hand_right/Position2D/Particles2D").emitting = false