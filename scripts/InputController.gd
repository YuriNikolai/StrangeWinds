extends Node

onready var weapon = get_parent().get_node("Weapon")

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		weapon.fire()
		#owner.get_node("Plane").hit(100)
		
	if Input.is_action_just_released("fire"):
		weapon.reload()
		
	if Input.is_action_just_pressed("rifle"):
		weapon.get_rifle()
		
	if Input.is_action_just_released("rifle"):
		weapon.drop_rifle()
