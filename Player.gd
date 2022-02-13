extends Node2D

export var flare_speed = 1000.0
export var fire_rate = 1
export var player_health = 100

var flare = preload("res://flare.tscn")
var can_fire = true

func _process(_delta):
	look_at(get_global_mouse_position())

func damage_player(amount):
	player_health -= amount
	if player_health < 0:
		player_health = 0
