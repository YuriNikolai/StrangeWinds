extends KinematicBody2D

signal player_damaged(new_health)

export var flare_speed = 1000.0
export var fire_rate = 1
export var player_health = 100

var flare = preload("res://flare.tscn")
var can_fire = true

func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and can_fire:

		var flare_instance = flare.instance()
		flare_instance.position = $BulletPoint.get_global_position()
		flare_instance.rotation_degrees = rotation_degrees
		flare_instance.apply_impulse(Vector2(), Vector2(flare_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(flare_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func damage_player(amount):
	player_health -= amount
	if player_health < 0:
		player_health = 0
	emit_signal("player_damaged", player_health)
