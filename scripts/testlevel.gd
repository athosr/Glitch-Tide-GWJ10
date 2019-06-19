extends Node2D

var player = preload("res://player/Player.tscn")

func _ready():
	$Position2D.add_child(player.instance())