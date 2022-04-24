extends Node2D


export var flare_rof : float # in rounds per second
export var rifle_rof : float # in rounds per second
export var rifle_damage = 10
export var is_hitscan : bool
export var muzzle_vel : int
export var penetrates : bool
export var max_pen : int
export(PackedScene) var projectile

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")

var sfx_flare_shoot = preload("res://sfx/flare_shoot.wav")
var sfx_eject = preload("res://sfx/eject.wav")
var sfx_flare_load1 = preload("res://sfx/flare_load1.wav")
var sfx_flare_load2 = preload("res://sfx/flare_load2.wav")
var sfx_trigger = preload("res://sfx/trigger.wav")
var sfx_rifle_shoot = preload("res://sfx/rifle_shoot.wav")
var sfx_rifle_ready = preload("res://sfx/navigation.wav")
var sfx_rifle_grab = preload("res://sfx/rifle_grab.wav")

onready var tween = get_parent().get_node("Tween")
onready var raycast = get_parent().get_node("RayCast2D")

var can_fire_flare : bool = true
var can_fire_rifle : bool = false
var loading = false

func _ready():
	if Global.day > 1:
		can_fire_rifle = true

func fire():
	if !is_hitscan and can_fire_flare:
		can_fire_flare = false
		
		var sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_trigger)
		
		yield(get_tree().create_timer(0.1), "timeout")
		
		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_flare_shoot)
		
		var projectile_instance = projectile.instance()
		projectile_instance.position = get_global_position()
		projectile_instance.rotation = get_parent().rotation
		projectile_instance.apply_impulse(Vector2(), Vector2(muzzle_vel, 0).rotated(get_parent().rotation))
		get_tree().get_root().add_child(projectile_instance)
		
		
		yield(get_tree().create_timer(1/flare_rof), "timeout")

	elif can_fire_rifle and is_hitscan:
		
		var sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_rifle_shoot)
		
		can_fire_rifle = false
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
					scan[i].hit(rifle_damage)
					scan[i].rifle_hit_particles()
			else:            #Stopping shot. Will stop on the first collider.
				line.add_point(raycast.get_collision_point())
				raycast.get_collider().hit(rifle_damage)
				raycast.get_collider().rifle_hit_particles()
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
		line.default_color = Color.orange
		line.width = 3
		line.modulate = Color(1.2, 1.2, 1.2, 1);  #Glowing
		line.z_index = 1
		get_tree().get_root().add_child(line)
		tween.interpolate_property(line, "default_color", line.default_color, Color(line.default_color.r, line.default_color.g, line.default_color.b, 0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
		tween.start()
		yield(get_tree().create_timer(1/rifle_rof), "timeout")
		line.queue_free()
		can_fire_rifle = true
		
		for x in 4:
			sound = AudioStreamer.instance()
			add_child(sound)
			sound.play_sound(sfx_rifle_ready)
			yield(get_tree().create_timer(0.12), "timeout")

func multi_scan(): #Scans all colliders, up to max_pen. Returns an array with all colliders. 
				   #Last element of array is the last collision point. If colliding with less than max_pen, last element will be 0,0.
	var colliders = []
	for _i in range(0, max_pen):
		if raycast.get_collider() == null:
			break
		else:
			var curr_collider = raycast.get_collider()
			colliders.append(curr_collider)
#			print(curr_collider)
			raycast.add_exception(curr_collider)
			raycast.force_raycast_update()
	if len(colliders) > 0 and len(colliders) < max_pen:
		colliders.append(Vector2(0, 0))
	else:
		colliders.append(raycast.get_collision_point())
	raycast.clear_exceptions()
#	print(colliders)
	return colliders
	
	
func get_rifle():
	is_hitscan = true
	
	var sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_rifle_grab)
	
	
func drop_rifle():
	is_hitscan = false
	
func reload():
	if !loading and !is_hitscan:
		loading = true
		var sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_flare_load2)

		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_eject)

		sound = AudioStreamer.instance()
		add_child(sound)
		sound.play_sound(sfx_flare_load1)
		
		yield(get_tree().create_timer(1), "timeout")
		
		loading = false
		can_fire_flare = true
