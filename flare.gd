extends RigidBody2D

export var flare_lifetime = 4
onready var _animated_sprite = $AnimatedSprite

#Make anim start on a consistent frame. Keep it at 8 FPS on the editor
func _ready():
	_animated_sprite.frame = 0

func _process(_delta):
	
	yield(get_tree().create_timer(flare_lifetime), "timeout")
	queue_free()
