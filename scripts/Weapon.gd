extends Node2D

# in rounds per second
export var rof : float

export var damage : float
export var is_hitscan : bool
export var muzzle_vel : int
export var penetrates : bool
export var max_pen : int
export(PackedScene) var projectile

onready var tween = get_parent().get_node("Tween")
onready var raycast = get_parent().get_node("RayCast2D")
var can_fire : bool = true

func fire():
	if !is_hitscan:
		can_fire = false
		var projectile_instance = projectile.instance()
		projectile_instance.position = get_global_position()
		projectile_instance.rotation = get_parent().rotation
		projectile_instance.apply_impulse(Vector2(), Vector2(muzzle_vel, 0).rotated(get_parent().rotation))
		get_tree().get_root().add_child(projectile_instance)
		yield(get_tree().create_timer(1/rof), "timeout")
		can_fire = true
	else:
		can_fire = false
		# I   AM  the   SON   of   GOD.
		var line = Line2D.new()
		var point_0 = get_parent().get_global_position()
		var point_1 = get_global_mouse_position()
		line.add_point(point_0)
		
		if raycast.is_colliding():
			if penetrates:   #Penetrating shot. If last element of multi_scan is 0,0, has penetrated less than the max and will continue into the distance. Else, will stop on the last collider.
				var scan = multi_scan()
				if scan[-1] == Vector2(0, 0):
					while point_1.x < 2000:
						point_1 = (Vector2(point_1.x*2, point_1.y*2)-point_0)
					line.add_point(point_1)
				else:
					line.add_point(scan[-1])
				for i in range(0, len(scan)-1):
					scan[i].hit(damage)
			else:            #Stopping shot. Will stop on the first collider.
				line.add_point(raycast.get_collision_point())
				raycast.get_collider().hit(damage)
		else:                #Loose shot. Has not collided.
			if point_1.x < point_0.x:
				while point_1.x > -1000:
					point_1 = (Vector2(point_1.x*2, point_1.y*2)-point_0)
			else:
				while point_1.x < 2000:
					point_1 = (Vector2(point_1.x*2, point_1.y*2)-point_0)
			line.add_point(point_1)
			
		line.begin_cap_mode = 2   #Rounded start
		line.end_cap_mode = 2     #Rounded end
		line.antialiased = true
		line.default_color = Color(0.91, 0.6, 0.33, 1) #Orange
		line.width = 3
		line.modulate = Color(1.2, 1.2, 1.2, 1);  #Glowing
		line.z_index = 1
		get_tree().get_root().add_child(line)
		tween.interpolate_property(line, "default_color", line.default_color, Color(line.default_color.r, line.default_color.g, line.default_color.b, 0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		tween.start()
		yield(get_tree().create_timer(1/rof), "timeout")
		can_fire = true


func multi_scan(): #Scans all colliders, up to max_pen. Returns an array with all colliders. 
				   #Last element of array is the last collision point. If colliding with less than max_pen, last element will be 0,0.
	var colliders = []
	for i in range(0, max_pen):
		if raycast.get_collider() == null:
			break
		else:
			var curr_collider = raycast.get_collider()
			colliders.append(curr_collider)
			print(curr_collider)
			raycast.add_exception(curr_collider)
			raycast.force_raycast_update()
	if len(colliders) > 0 and len(colliders) < max_pen:
		colliders.append(Vector2(0, 0))
	else:
		colliders.append(raycast.get_collision_point())
	raycast.clear_exceptions()
	print(colliders)
	return colliders
