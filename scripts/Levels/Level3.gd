extends Node2D

var ending = preload("res://scenes/Etc/ending.tscn")

var player = preload('res://player/Player.tscn')

var did : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Effects.play('weather')
	$Effects.play('weather')
	pass


func _on_RideCreature_body_entered(body):
	if body.is_in_group('player'):
		$CameraEffects.play("Camera")
		$Creature.play('creature_flying')
		if not did:
			$CanvasLayer.add_child(ending.instance())
			did = true
	
func _on_RideCreature_body_exited(body):
	if body.is_in_group('player'):
		$CameraEffects.play_backwards("Camera")