extends KinematicBody2D

enum {
	ADVANCING,
	SHOOTING,
	DYING
}

var state = ADVANCING

onready var hitbox = $CollisionShape2D
onready var ap = $AnimationPlayer

func _ready():
	generate_path()

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
			ap.play("shoot")

func generate_path():
	pass
