extends KinematicBody2D

export var hp = 10
export var attack_range = 600
export var attack_dmg = 15
export var speed = 100

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_artilect_beam = preload("res://sfx/rlaunch.wav")
var sfx_boom = preload("res://sfx/boom.wav")

var target_vector : Vector2
var target : Vector2
var shot = false

var player_pos = Vector2(220, 551)
onready var plane = get_parent().get_node("Plane")

enum {
	ADVANCING,
	SHOOTING,
	DYING
}

var state = ADVANCING

onready var hitbox = $CollisionShape2D
onready var ap = $AnimationPlayer
onready var line = $Line2D
var dead = false
var linespawn = false

func _ready():
	target_vector = (target-global_position).normalized()*speed

func _physics_process(delta):
	if (position.distance_to(target) < 50 or position.x < target.x) and (state != SHOOTING):
		state = SHOOTING
	elif state == ADVANCING:
		move_and_slide(target_vector/rand_range(90, 110)*speed)
		

func _process(delta):
	#print(ap.current_animation)
	look_at(player_pos)
	#print(get_children())
	match state:
		ADVANCING:
			#print ("Advancing state")
			ap.play("advance")
		SHOOTING:
			#print ("Shooting state")
			if !shot:
				shot = true
				ap.play("shoot")
			if linespawn:
				plane.hit(attack_dmg*delta)
		DYING:
			#print ("dying state")
			if !dead:
				linespawn = false
				line.queue_free()
				dead = true
				ap.play("die")
				hitbox.set_deferred("disabled", true)
				Global.population -= 1
	
func hit(dmg):
	
	hp -= dmg
	if hp <= 0:
		state = DYING
	
	var sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_boom)

func rifle_hit_particles():
	$CPUParticles2D.restart()
	$CPUParticles2D.emitting = true

func shoot():
	linespawn = true
	
	var sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_artilect_beam)
	
	line.add_point($ShootFrom.position)
	line.add_point(to_local(get_parent().get_node("EnemiesTarget").position))
	line.z_index = 1
	line.width = 4
	line.default_color = Color.orange
	line.end_cap_mode = 2               #Rounded start
	line.begin_cap_mode = 2             #Rounded end
	line.modulate = Color(1.2, 1.2, 1.2, 1)
	line.visible = true
