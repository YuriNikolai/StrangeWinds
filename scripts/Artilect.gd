extends KinematicBody2D

export var hp : float
export var attack_range = 600
export var speed = 10

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

func _ready():
	target_vector = target-global_position

func _physics_process(delta):
	if position.distance_to(player_pos) < attack_range + 100:
		position = lerp(position, target, rand_range(0.0001, 0.01))
	else:
		move_and_slide(target_vector/rand_range(90, 110)*speed)
		

func _process(_delta):
	match state:
		ADVANCING:
			#print ("Advancing state")
			ap.play("advance")
		SHOOTING:
			#print ("Shooting state")
			ap.play("shoot")
		DYING:
			#print ("Dying state")
			ap.play("die")
	
func hit(dmg):
	hp -= dmg
