extends Node

onready var weapon = get_parent().get_node("Weapon")

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_eject = preload("res://sfx/eject.wav")
var sfx_flare_load1 = preload("res://sfx/flare_load1.wav")
var sfx_flare_load2 = preload("res://sfx/flare_load2.wav")
var sfx_dry_fire = preload("res://sfx/dry_fire.wav")

var fired_this_click = false

func _process(_delta):
	if Input.is_action_pressed("fire") and weapon.can_fire:
		weapon.fire()
		fired_this_click = true
		owner.get_node("Plane").hit(100)
	
	if Input.is_action_just_pressed("fire") and weapon.can_fire == false:
		var sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_dry_fire)
	
	if Input.is_action_just_released("fire") and fired_this_click:
		var sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_flare_load2)
		
		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_eject)
		
		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_flare_load1)
		
		fired_this_click = false
