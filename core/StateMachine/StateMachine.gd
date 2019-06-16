extends Node
class_name StateMachine

signal state_changed(current_state)

var states_stack : Array = []
var states_map : = {}
var current_state : State = null
var _active : = false setget set_active

export var START_STATE : NodePath

func _ready() -> void:
	for child in get_children():
		child.connect("finished", self, "_change_state")

	initialize(START_STATE)


func initialize(start_state : NodePath) -> void:
	set_active(true)
	current_state = get_node(start_state)
	states_stack.push_front(start_state)
	current_state.enter()


func set_active(value : bool) -> void:
	_active = value
	set_physics_process(value)
	set_process_input(value)
	if not _active:
		states_stack = []
		current_state = null


func _physics_process(delta : float) -> void:
	current_state.update(delta)


func _input(event : InputEvent) -> void:
	current_state.handle_input(event)


func _on_animation_finished(anim_name : String) -> void:
	if not _active:
		return
	current_state._on_animation_finished(anim_name)


func _change_state(state_name : String) -> void:
	if not _active:
		return

	current_state.exit()
		
	if state_name == "previous":
		states_stack.pop_front()
	else:
		states_stack[0] = states_map[state_name]
		
	current_state = states_stack[0]
	emit_signal("state_changed", current_state)
	
	if state_name != "previous":
		current_state.enter()