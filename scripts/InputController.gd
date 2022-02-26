extends Node

onready var weapon = get_parent().get_node("Weapon")

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		weapon.fire()
		
	if Input.is_action_just_released("fire"):
		weapon.reload()
		
	if Input.is_action_just_pressed("rifle"):
		weapon.get_rifle()
		
	if Input.is_action_just_released("rifle"):
		weapon.drop_rifle()
