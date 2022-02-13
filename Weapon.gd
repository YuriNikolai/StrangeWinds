extends Node2D

# in rounds per second
export var rof : float = 1.0

export var damage : float = 1.0
export var is_hitscan : bool = false
export var muzzle_vel : int = 1000
export(PackedScene) var projectile

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
