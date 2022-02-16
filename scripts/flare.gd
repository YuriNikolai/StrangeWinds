extends RigidBody2D

onready var _animated_sprite = $AnimatedSprite

#Make anim start on a consistent frame. Keep it at 8 FPS on the editor
func _ready():
	_animated_sprite.frame = 0

func _on_LifeTimer_timeout():
	queue_free()
