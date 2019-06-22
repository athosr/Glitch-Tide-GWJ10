extends Node

var deaths : int = 0
var init : bool = false
var current_scene = null
var debug : bool = false

func _process(delta):
    var root = get_tree().get_root()
    current_scene = root.get_child(root.get_child_count() - 1)
