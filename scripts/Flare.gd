extends RigidBody2D

onready var _animated_sprite = $AnimatedSprite


func _ready():
	_animated_sprite.frame = 0 #Makes anim start on a consistent frame

func _on_LifeTimer_timeout():
	queue_free()
