extends RigidBody2D

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_boom = preload("res://sfx/boom.wav")

onready var _animated_sprite = $AnimatedSprite
onready var raycast = [$RayCast2DLeft, $RayCast2DCenter, $RayCast2DRight]

export var flare_damage = 5

var burned = false

func _ready():
	_animated_sprite.frame = 0 #Makes anim start on a consistent frame

func _physics_process(delta):
#	print(raycast.get_collider())
	for i in range(0, len(raycast)-1):
		if raycast[i].is_colliding() and burned != true:
			burned = true
			raycast[i].get_collider().hit(flare_damage)
			flare_hit_particles()

func _on_LifeTimer_timeout():
	queue_free()

func flare_hit_particles():
	var hit_particles_instance = CPUParticles2D.new()
	hit_particles_instance.emitting = true
	hit_particles_instance.one_shot = true
	hit_particles_instance.amount = 512
	hit_particles_instance.lifetime = 0.5
	hit_particles_instance.explosiveness = 1
	hit_particles_instance.randomness = 0.5
	hit_particles_instance.lifetime_randomness = 10
	hit_particles_instance.direction.x = 0
	hit_particles_instance.spread = 152
	hit_particles_instance.gravity.x = 0
	hit_particles_instance.emission_shape = 1 #Sphere
	hit_particles_instance.initial_velocity = 66.66
	hit_particles_instance.linear_accel = 22.22
	hit_particles_instance.linear_accel_random = 0.13
	hit_particles_instance.radial_accel = 9.0
	hit_particles_instance.damping = 43.22
	hit_particles_instance.scale_amount = 1.5
	hit_particles_instance.color = Color.orange
	hit_particles_instance.z_index = 1
	hit_particles_instance.modulate = Color(1.2, 1.2, 1.2, 1) #Glow
	hit_particles_instance.position = Vector2(get_global_position().x, get_global_position().y)
	get_tree().root.get_child(0).add_child(hit_particles_instance)
	queue_free()
