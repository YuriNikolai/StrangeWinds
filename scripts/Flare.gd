extends RigidBody2D

var AudioStreamer = preload("res://scenes/AudioStreamer.tscn")
var sfx_boom = preload("res://sfx/boom.wav")

onready var _animated_sprite = $AnimatedSprite
onready var raycast = $RayCast2D

export var flare_damage = 5

var burned = false

func _ready():
	_animated_sprite.frame = 0 #Makes anim start on a consistent frame

func _physics_process(delta):
#	print(raycast.get_collider())
	if raycast.is_colliding() and burned != true:
		burned = true
		raycast.get_collider().hit(flare_damage)	
		queue_free()

func _on_LifeTimer_timeout():
	queue_free()

func hit(dmg):
	pass
