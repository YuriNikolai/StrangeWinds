extends KinematicBody2D

export var hp = 10
export var attack_range = 600
export var attack_dmg = 10
export var speed = 1000

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_artilect_beam = preload("res://sfx/rlaunch.wav")
var sfx_boom = preload("res://sfx/boom.wav")

var target_vector : Vector2
var target : Vector2

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
var dead = false
var shot = false

func _ready():
	target_vector = (target-global_position).normalized()*speed

func _physics_process(delta):
	if (position.distance_to(target) < 50 or position.x < target.x) and (state != SHOOTING):
		state = SHOOTING
	elif state == ADVANCING:
		move_and_slide(target_vector/rand_range(90, 110)*speed)
		

func _process(_delta):
#	print(ap.current_animation)
	look_at(player_pos)
	match state:
		ADVANCING:
			#print ("Advancing state")
			ap.play("advance")
		SHOOTING:
			#print ("Shooting state")
			if !shot:
				shot = true
				ap.play("shoot")
		DYING:
			#print ("dying state")
			if !dead:
				dead = true
				ap.play("die")
				hitbox.set_deferred("disabled", true)
				yield(get_tree().create_timer(5), "timeout")
				call_deferred("free")
	
func hit(dmg):
	
	hp -= dmg
	if hp <= 0:
		state = DYING
	
	var sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_boom) #this is here and not on the flare script for now until i debug the sound cutoff that happens there
	
	$CPUParticles2D.emitting = true

func shoot():
	
	var sound = AudioStreamer.instance()
	add_child(sound)
	sound.play_sound(sfx_artilect_beam)
	
	var line = Line2D.new()
	line.add_point(to_global($ShootFrom.position))
	line.add_point(get_parent().get_node("EnemiesTarget").position)
	line.z_index = 1
	line.width = 4
	line.default_color = Color.orange
	line.end_cap_mode = 2               #Rounded start
	line.begin_cap_mode = 2             #Rounded end
	line.modulate = Color(1.2, 1.2, 1.2, 1)
	get_tree().get_root().add_child(line)
	while(state != DYING):
		plane.hit(attack_dmg)
		yield(get_tree().create_timer(1), "timeout")
	line.queue_free() #not working, line stays forever even after death
