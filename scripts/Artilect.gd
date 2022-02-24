extends KinematicBody2D

export var hp = 10
export var attack_range = 600
export var speed = 100

var target_vector : Vector2
var target : Vector2

var player_pos = Vector2(220, 551)

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
	print (hp)
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
			
	
func hit(dmg):
	hp -= dmg
	if hp <= 0:
		state = DYING
