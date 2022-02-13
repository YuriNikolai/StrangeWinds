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
	pass # Replace with function body.

func _process(_delta):
	
#	if hitbox.area_entered():
#		state = SHOOTING
		
	match state:
		ADVANCING:
			#print ("Advancing state")
			ap.play("shoot")
		SHOOTING:
			#print ("Shooting state")
			ap.play("shoot")
		DYING:
			#print ("Dying state")
			ap.play("shoot")
