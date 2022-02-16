extends Node

onready var weapon = get_parent().get_node("Weapon")

func _process(delta):
	if Input.is_action_pressed("fire") and weapon.can_fire:
		weapon.fire()
		owner.get_node("Plane").hit(100)
