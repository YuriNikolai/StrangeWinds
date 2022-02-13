extends Node2D

# in rounds per second
export var rof : float = 1.0

export var damage : float = 1.0
export var is_hitscan : bool = true
export var muzzle_vel : int = 1300
export(PackedScene) var projectile

onready var tween = get_parent().get_node("Tween")
var can_fire : bool = true

func fire():
	if !is_hitscan:
		can_fire = false
		var projectile_instance = projectile.instance()
		print("flare")
		projectile_instance.position = get_global_position()
		projectile_instance.rotation = get_parent().rotation
		projectile_instance.apply_impulse(Vector2(), Vector2(muzzle_vel, 0).rotated(get_parent().rotation))
		get_tree().get_root().add_child(projectile_instance)
		yield(get_tree().create_timer(1/rof), "timeout")
		can_fire = true
	else:
		can_fire = false
		print("hitscan")
		
		# I   AM  the   SON   of   GOD.
		var line = Line2D.new()
		var point_0 = get_parent().get_global_position()
		var point_1 = get_global_mouse_position()
		
		#nothing to see here, this is all good code
		var point_2 = (Vector2(point_1.x*2, point_1.y*2)-point_0)
		var point_3 = (Vector2(point_2.x*2, point_2.y*2)-point_0)
		var point_4 = (Vector2(point_3.x*2, point_3.y*2)-point_0)
		line.add_point(point_0)
		line.add_point(point_4)
	
		line.antialiased = true
		line.default_color = Color(0.91, 0.6, 0.33, 1)
		line.width = 3
		line.modulate = Color(1.2, 1.2, 1.2, 1);
		line.z_index = 1
		get_tree().get_root().add_child(line)
		
		tween.interpolate_property(line, "default_color", line.default_color, Color(line.default_color.r, line.default_color.g, line.default_color.b, 0), 0.4, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		tween.start()
		
		
		yield(get_tree().create_timer(0.1), "timeout")
		can_fire = true
