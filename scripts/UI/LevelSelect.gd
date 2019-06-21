extends Control


func _on_menu_pressed():
	return get_tree().change_scene("res://scenes/Interface/Menu.tscn")


func _on_Level1_pressed():
	get_tree().change_scene("res://scenes/Levels/Level1.tscn")
func _on_Level2_pressed():
	get_tree().change_scene("res://scenes/Levels/Level2.tscn")