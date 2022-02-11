extends KinematicBody2D

export var flare_speed = 1000.0
export var fire_rate = 1
export(Curve) var flare_faloff

var flare_curve = 0
var flare = preload("res://flare.tscn")
var can_fire = true

func _process(delta):
	look_at(get_global_mouse_position())
	#flare_speed = flare_faloff.interpolate(flare_curve)
	
	if Input.is_action_pressed("fire") and can_fire:
		print(flare_curve)
		print(flare_speed)
		print(flare_faloff)
		var flare_instance = flare.instance()
		flare_instance.position = $BulletPoint.get_global_position()
		flare_instance.rotation_degrees = rotation_degrees
		flare_instance.apply_impulse(Vector2(), Vector2(flare_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(flare_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
		#flare_instance.apply_impulse(Vector2(), Vector2(-flare_speed, 0).rotated(rotation))
		print(flare_curve)
		print(flare_speed)
		print(flare_faloff)
